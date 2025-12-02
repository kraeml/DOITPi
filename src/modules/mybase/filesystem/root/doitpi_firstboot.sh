#!/bin/bash
# doitpi_firstboot.sh – Post-installation script for DoitPi
# Purpose: One-time post-installation script to:
#          - Replace legacy user/paths (e.g., /home/pi → dynamic user)
#          - Update system packages (if internet is available)
#          - Run Ansible playbooks for system configuration

set -euo pipefail  # Fail on errors, unset variables, and pipeline errors

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
        find "${dir}" -type f -exec grep -l "${search}" {} + | while read -r file; do
            sed -i "s@${search}@${replace}@g" "${file}"
        done
    fi
}

update-locale LANG=de_DE.UTF8

# Check for internet connectivity (3 attempts, timeout 2s each)
if ping -c 3 -W 2 9.9.9.9 &>/dev/null || curl --connect-timeout 2 -sI https://1.1.1.1 &>/dev/null; then
    HAS_INTERNET=true
else
    HAS_INTERNET=false
    log "Warning: No internet connection. Skipping network-dependent tasks."
fi

# Get dynamic user home and name (UID 1000 = first non-system user)
export USER_HOME=$(getent passwd 1000 | cut --delimiter=: --fields=6)
export USER_NAME=$(getent passwd 1000 | cut --delimiter=: --fields=1)

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

ANSIBLE_BASE_ARGS="--limit lokal --tags autohotspot"   # Minimal tags for offline execution
ANSIBLE_FULL_ARGS="${ANSIBLE_BASE_ARGS},firstrun,mybase" # Minimal tags for offline execution

if [ -d "${USER_HOME}/workspace/doitpi-ansible" ]; then
  cd ${USER_HOME}/workspace/doitpi-ansible/
  if [ "${HAS_INTERNET}" = true ]; then
      sudo -u "#1000" ansible-playbook ${ANSIBLE_FULL_ARGS} main.yaml | tee -a "${USER_HOME}/.ansible-playbook-$(date +%Y-%m-%d_%H-%M-%S).log
  else
      sudo -u "#1000" ansible-playbook ${ANSIBLE_BASE_ARGS} main.yaml | tee -a "${USER_HOME}/.ansible-playbook-$(date +%Y-%m-%d_%H-%M-%S).log"
  fi
  cd -
fi

# Remove force-confnew config (forces new config files on package updates)
if [ -f /etc/apt/apt.conf.d/99forceconfnew ]; then
  rm /etc/apt/apt.conf.d/99forceconfnew
fi

# Löschen von doitpi_firstboot, wenn Internetverbindung besteht
if [ "${HAS_INTERNET}" = true ]; then
  systemctl disable --now doitpi_firstboot.service ||  log "Warning: Failed to disable service."
  sync
  log "Rebooting in 20 seconds..."
  sleep 20
  reboot
fi
