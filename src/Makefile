MAKEFLAGS += "--jobs=$(shell nproc)"

# https://downloads.raspberrypi.com/raspios_lite_arm64/images/
RASPIOS_DATE ?= 2024-07-04
RASPIOS_DATE_URL ?= 2024-07-04

RASPIOS_NAME ?= bookworm

RASPIOS_LITE_ARMHF_VERSION = ${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-armhf-lite
IMAGE_ARMHF = image
IMAGE_NAME_ARMHF = ${IMAGE_ARMHF}/${RASPIOS_LITE_ARMHF_VERSION}
WORKSPACE_ARMHF = workspace-raspios
WORKSPACE_ARMHF_NAME = ${WORKSPACE_ARMHF}/${RASPIOS_LITE_ARMHF_VERSION}

RASPIOS_LITE_ARM64_VERSION = ${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-arm64-lite
IMAGE_ARM64 = image-raspios_lite_arm64
IMAGE_NAME_ARM64 = ${IMAGE_ARM64}/${RASPIOS_LITE_ARM64_VERSION}
WORKSPACE_ARM64 = workspace-raspios_lite_arm64
WORKSPACE_ARM64_NAME = ${WORKSPACE_ARM64}/${RASPIOS_LITE_ARM64_VERSION}

UBUNTU_RELEASE ?= 24.04
# Setze auf .4 bei Patchlevel 4 der Punkt ist WICHTIG
UBUNUT_PATCHLEVEL = 
UBUNTU_SERVER_ARM64_VERSION = ubuntu-${UBUNTU_RELEASE}${UBUNUT_PATCHLEVEL}-preinstalled-server-arm64+raspi
IMAGE_UBUNTU = image-ubuntu_arm64

IMAGE_NAME_UBUNTU = ${IMAGE_UBUNTU}/${UBUNTU_SERVER_ARM64_VERSION}
WORKSPACE_UBUNTU = workspace-ubuntu_arm64
WORKSPACE_UBUNTU_NAME = ${WORKSPACE_UBUNTU}/${UBUNTU_SERVER_ARM64_VERSION}

.PHONY: git_status clean_all clean_images clean_workspaces build_clean ubuntu_clean arm64_clean armhf_clean release all lokal custompios_pre
.SECONDARY: ${IMAGE_NAME_ARMHF}.img.xz ${IMAGE_NAME_ARM64}.img.xz ${IMAGE_NAME_UBUNTU}.img.xz ${WORKSPACE_ARMHF_NAME}.img ${WORKSPACE_ARM64_NAME}.img ${WORKSPACE_UBUNTU_NAME}.img

all: | ubuntu armhf arm64

custompios_pre:
	@if ! grep -q "lazy" ../../CustomPiOS/src/common.sh; then \
	sed -i 's/sudo umount $m/sudo umount --lazy --force $m/g' ../../CustomPiOS/src/common.sh; \
	fi;

build_all: custompios_pre all
	@sync
	@sleep 10
	$(MAKE) ubuntu


build_clean: clean_all build_all

armhf_image: | ${WORKSPACE_ARMHF_NAME}.img

arm64_image: | ${WORKSPACE_ARM64_NAME}.img

ubuntu_image: | ${WORKSPACE_UBUNTU_NAME}.img

armhf: | ${WORKSPACE_ARMHF_NAME}.img.xz

arm64: | ${WORKSPACE_ARM64_NAME}.img.xz

ubuntu: | ${WORKSPACE_UBUNTU_NAME}.img.xz

${IMAGE_NAME_ARMHF}.img.xz:
	@echo wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-${RASPIOS_DATE_URL}/${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-armhf-lite.img.xz' 
	@cd ./${IMAGE_ARMHF}/ ; \
	wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-${RASPIOS_DATE_URL}/${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-armhf-lite.img.xz'

${IMAGE_NAME_ARM64}.img.xz:
	@echo wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-${RASPIOS_DATE_URL}/${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-arm64-lite.img.xz'
	@cd ./${IMAGE_ARM64}/ ; \
	wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-${RASPIOS_DATE_URL}/${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-arm64-lite.img.xz'

${IMAGE_NAME_UBUNTU}.img.xz:
	@echo wget --continue --quiet --trust-server-names 'https://cdimage.ubuntu.com/releases/${UBUNTU_RELEASE}/release/${UBUNTU_SERVER_ARM64_VERSION}.img.xz'
	@cd ./${IMAGE_UBUNTU} ; \
	wget --continue --quiet --trust-server-names 'https://cdimage.ubuntu.com/releases/${UBUNTU_RELEASE}/release/${UBUNTU_SERVER_ARM64_VERSION}.img.xz'

armhf_clean:
	@sudo rm ./${WORKSPACE_ARMHF}/*.xz 2>/dev/null || true
	@sudo rm ./${WORKSPACE_ARMHF}/*.img 2>/dev/null || true

arm64_clean:
	@sudo rm ./${WORKSPACE_ARM64}/*.xz 2>/dev/null || true
	@sudo rm ./${WORKSPACE_ARM64}/*.img 2>/dev/null || true

ubuntu_clean:
	@sudo rm ./${WORKSPACE_UBUNTU}/*.xz 2>/dev/null || true
	@sudo rm ./${WORKSPACE_UBUNTU}/*.img 2>/dev/null || true

clean_images:
	@rm ./image*/*.xz 2>/dev/null || true

clean_workspaces: | ubuntu_clean arm64_clean armhf_clean 

clean_all: clean_images clean_workspaces

${WORKSPACE_ARMHF_NAME}.img: | ${IMAGE_NAME_ARMHF}.img.xz
	@sudo bash ./build_dist raspios
	@echo Build raspios_armhf finished
	@sync

${WORKSPACE_ARMHF_NAME}.img.xz: | ${WORKSPACE_ARMHF_NAME}.img
	@pv --progress ./${WORKSPACE_ARMHF_NAME}.img | sudo xz --extreme --threads=0 | sudo tee ${WORKSPACE_ARMHF_NAME}.img.xz >/dev/null
	@sync
	@sudo rm ./${WORKSPACE_ARMHF_NAME}.img

${WORKSPACE_ARM64_NAME}.img: | ${IMAGE_NAME_ARM64}.img.xz
	@sudo bash ./build_dist raspios_lite_arm64
	@echo Build raspios_lite_arm64 finished
	@sync

${WORKSPACE_ARM64_NAME}.img.xz: | ${WORKSPACE_ARM64_NAME}.img
	@pv --progress ./${WORKSPACE_ARM64_NAME}.img | sudo xz --extreme --threads=0 | sudo tee ${WORKSPACE_ARM64_NAME}.img.xz >/dev/null
	@sync
	@sudo rm ./${WORKSPACE_ARM64_NAME}.img
	
${WORKSPACE_UBUNTU_NAME}.img: | ${IMAGE_NAME_UBUNTU}.img.xz
	@sudo bash ./build_dist ubuntu_arm64
	@echo Build ubuntu_arm64 finished
	@sync

${WORKSPACE_UBUNTU_NAME}.img.xz: | ${WORKSPACE_UBUNTU_NAME}.img
	@pv --progress ./${WORKSPACE_UBUNTU_NAME}.img | sudo xz --extreme --threads=0 | sudo tee ${WORKSPACE_UBUNTU_NAME}.img.xz >/dev/null
	@sync
	@sudo rm ./${WORKSPACE_UBUNTU_NAME}.img

lokal: arm64_clean arm64_image

# Es wird geprüft, ob Änderungen im Git-Repository gibt und ob die Versionsnummern in der config Datei und im CHANGELOG.md Dokument übereinstimmen.
# Wenn entweder eine Änderung gefunden wird oder die Versionen nicht übereinstimmen, wird das Skript mit einem entsprechenden Fehlerstatus beendet.
git_status:
	@if git status --porcelain | grep .; \
		then \
		echo Git-Repository enthält Änderungen; \
		exit 1; \
	fi
	@if [ ! $$(grep DIST_VERSION config | cut -d 'v' -f 2) = $$(grep VERSION ../CHANGELOG.md | head -n 1 | cut -d '=' -f 2) ]; \
		then \
		echo Versionsnummern stimmen nicht überein; \
		exit 2; \
	fi

release: git_status 
	@release=$$(grep VERSION ../CHANGELOG.md | head -n 1 | cut -d '=' -f 2); \
	git flow release start v$${release}; \
	#sed -i 's@DIST_VERSION=v.*@DIST_VERSION=v'$${release}'@g' config; \
	#major=$$(echo "$${release}" | awk -F"." '{print $$1}'); \
	#minor=$$(echo "$${release}" | awk -F"." '{print $$2}'); \
	#patch=$$(echo "$${release}" | awk -F"." '{print $$3}'); \
	#new_patch=$$(echo "$$patch + 1" | bc); \
	#new_version="$$major.$$minor.$$new_patch"; \
	#sed -i '1s/^/VERSION='$$new_version'\n- [ ] \n/' ../CHANGELOG.md
