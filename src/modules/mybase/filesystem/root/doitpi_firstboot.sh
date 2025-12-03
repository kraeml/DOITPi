#!/bin/bash
# doitpi_firstboot.sh – Post-installation script for DoitPi
# Purpose: One-time post-installation script to:
#          - Replace legacy user/paths (e.g., /home/pi → dynamic user)
#          - Update system packages (if internet is available)
#          - Run Ansible playbooks for system configuration

set -euo pipefail  # Stop on errors/unset variables, and fail if any pipe command fails

# Exit if not running as root - required for system-wide changes below
if (( EUID != 0 )); then
  echo "This script must be run as root." >&2
  exit 1
fi

# Get passwd entry of the default user (UID 1000) or exit if none found
USER_ENTRY=$(getent passwd 1000 || true)
if [ -z "$USER_ENTRY" ]; then
  log "Error: No user with UID 1000 found."
  exit 1
fi

# Log function to print messages with timestamp
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $@" >&2
}

# Replace occurrences of $1 with $2 in files under $3
replace_in_files() {
    local search="$1"
    local replace="$2"
    local dir="$3"
    if [ -d "${dir}" ]; then
        find "${dir}" -type f -print0 | xargs -0 sed -i "s|${search}|${replace}|g"
    fi
}

# Set system locale to German UTF-8
update-locale LANG=de_DE.UTF-8

# Check for internet connectivity (3 attempts, timeout 2s each)
if ping -c 3 -W 2 9.9.9.9 &>/dev/null || curl --connect-timeout 2 -sI https://1.1.1.1 &>/dev/null; then
    HAS_INTERNET=true
else
    HAS_INTERNET=false
    log "Warning: No internet connection. Skipping network-dependent tasks."
fi

# Get dynamic user home and name (UID 1000 = first non-system user)
export USER_HOME=$(echo "$USER_ENTRY" | cut --delimiter=: --fields=6)
export USER_NAME=$(echo "$USER_ENTRY" | cut --delimiter=: --fields=1)

# Replace legacy paths and usernames in systemd services
replace_in_files "/home/pi" "${USER_HOME}" /etc/systemd/system
replace_in_files "User=pi" "User=${USER_NAME}" /etc/systemd/system

# Clean up Python cache files (may contain legacy paths)
find "${USER_HOME}/" -name '*.pyc' -delete

# Update APT cache if internet is available
if [ "${HAS_INTERNET}" = true ]; then
  ansible --extra-vars ansible_python_interpreter=/usr/bin/python3 \
    --inventory localhost, --connection local \
    --module-name apt \
    --args "update_cache=yes cache_valid_time=3600" localhost
fi

# Restart cockpit_installer if service file exists
if [ -f /etc/systemd/system/cockpit_installer.service ]; then
  systemctl restart cockpit_installer
fi

# Set Ansible tags for playbook runs: minimal offline and full with internet
ANSIBLE_BASE_ARGS="--limit lokal --tags autohotspot"   # Minimal tags for offline execution
ANSIBLE_FULL_ARGS="${ANSIBLE_BASE_ARGS},firstrun,mybase" # Minimal tags for offline execution

# Run Ansible playbooks as dynamic user if ansible directory exists
if [ -d "${USER_HOME}/workspace/doitpi-ansible" ]; then
  cd ${USER_HOME}/workspace/doitpi-ansible/
  if [ "${HAS_INTERNET}" = true ]; then
      sudo -u "${USER_NAME}" ansible-playbook main.yaml ${ANSIBLE_FULL_ARGS} | \
        tee -a "${USER_HOME}/.ansible-playbook-$(date +%Y-%m-%d_%H-%M-%S).log"
  else
      sudo -u "${USER_NAME}" ansible-playbook main.yaml ${ANSIBLE_BASE_ARGS} | \
        tee -a "${USER_HOME}/.ansible-playbook-$(date +%Y-%m-%d_%H-%M-%S).log"
  fi
  cd - >/dev/null || true
fi

# Remove force-confnew config (forces new config files on package updates)
if [ -f /etc/apt/apt.conf.d/99forceconfnew ]; then
  rm /etc/apt/apt.conf.d/99forceconfnew
fi

# Disable and stop this script's systemd service if internet is present, then reboot cleanly
if [ "${HAS_INTERNET}" = true ]; then
  systemctl disable --now doitpi_firstboot.service ||  log "Warning: Failed to disable service."
  sync
  log "Rebooting in 20 seconds..."
  sleep 20
  systemctl reboot
fi
