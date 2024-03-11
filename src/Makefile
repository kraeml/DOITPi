MAKEFLAGS += "--jobs=$(shell nproc)"
RASPIOS_DATE ?= 2023-12-11
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

UBUNTU_RELEASE ?= 22.04
UBUNUT_PATCHLEVEL ?= 4
UBUNTU_SERVER_ARM64_VERSION = ubuntu-${UBUNTU_RELEASE}.${UBUNUT_PATCHLEVEL}-preinstalled-server-arm64+raspi
IMAGE_UBUNTU = image-ubuntu_arm64

IMAGE_NAME_UBUNTU = ${IMAGE_UBUNTU}/${UBUNTU_SERVER_ARM64_VERSION}
WORKSPACE_UBUNTU = workspace-ubuntu_arm64
WORKSPACE_UBUNTU_NAME = ${WORKSPACE_UBUNTU}/${UBUNTU_SERVER_ARM64_VERSION}

.PHONY: clean_all clean_images clean_workspaces build_clean build_all ubuntu_clean arm64_clean armhf_clean release arm64 ubuntu armhf all
.SECONDARY: ${IMAGE_NAME_ARMHF}.img.xz ${IMAGE_NAME_ARM64}.img.xz ${IMAGE_NAME_UBUNTU}.img.xz ${WORKSPACE_ARMHF_NAME}.img ${WORKSPACE_ARM64_NAME}.img ${WORKSPACE_UBUNTU_NAME}.img

all: build_all

custompios_pre:
	@sed -i 's/sudo umount $m/sudo umount --lazy --force $m/g' ../../CustomPiOS/src/common.sh

build_all: | custompios_pre armhf arm64
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
	@cd ./${IMAGE_ARMHF}/ ; \
	wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-${RASPIOS_DATE}/${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-armhf-lite.img.xz'

${IMAGE_NAME_ARM64}.img.xz:
	@cd ./${IMAGE_ARM64}/ ; \
	wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-${RASPIOS_DATE}/${RASPIOS_DATE}-raspios-${RASPIOS_NAME}-arm64-lite.img.xz'

${IMAGE_NAME_UBUNTU}.img.xz:
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
	@pv ./${WORKSPACE_ARMHF_NAME}.img | sudo xz > ${WORKSPACE_ARMHF_NAME}.img.xz
	@sync
	@sudo rm ./${WORKSPACE_ARMHF_NAME}.img

${WORKSPACE_ARM64_NAME}.img: | ${IMAGE_NAME_ARM64}.img.xz
	@sudo bash ./build_dist raspios_lite_arm64
	@echo Build raspios_lite_arm64 finished
	@sync

${WORKSPACE_ARM64_NAME}.img.xz: | ${WORKSPACE_ARM64_NAME}.img
	@pv ./${WORKSPACE_ARM64_NAME}.img | sudo xz > ${WORKSPACE_ARM64_NAME}.img.xz
	@sync
	@sudo rm ./${WORKSPACE_ARM64_NAME}.img
	
${WORKSPACE_UBUNTU_NAME}.img: | ${IMAGE_NAME_UBUNTU}.img.xz
	@sudo bash ./build_dist ubuntu_arm64
	@echo Build ubuntu_arm64 finished
	@sync

${WORKSPACE_UBUNTU_NAME}.img.xz: | ${WORKSPACE_UBUNTU_NAME}.img
	@pv ./${WORKSPACE_UBUNTU_NAME}.img | sudo xz > ${WORKSPACE_UBUNTU_NAME}.img.xz
	@sync
	@sudo rm ./${WORKSPACE_UBUNTU_NAME}.img

release:
	release=$$(grep VERSION ../CHANGELOG.md | head -n 1 | cut -d '=' -f 2); \
	git flow release start v$${release}; \
	#sed -i 's@DIST_VERSION=v.*@DIST_VERSION=v'$${release}'@g' config; \
	#major=$$(echo "$${release}" | awk -F"." '{print $$1}'); \
	#minor=$$(echo "$${release}" | awk -F"." '{print $$2}'); \
	#patch=$$(echo "$${release}" | awk -F"." '{print $$3}'); \
	#new_patch=$$(echo "$$patch + 1" | bc); \
	#new_version="$$major.$$minor.$$new_patch"; \
	#sed -i '1s/^/VERSION='$$new_version'\n- [ ] \n/' ../CHANGELOG.md