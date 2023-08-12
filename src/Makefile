MAKEFLAGS+="-j "

RASPIOS_LITE_ARMHF_VERSION = 2023-05-03-raspios-bullseye-armhf-lite
RASPIOS_LITE_ARM64_VERSION = 2023-05-03-raspios-bullseye-arm64-lite
UBUNTU_SERVER_ARM64_VERSION = ubuntu-22.04.3-preinstalled-server-arm64+raspi

all: build_all

build_all: | ubuntu

build_clean: clean_all build_all

ubuntu: workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz

arm64: workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz

armhf: workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img.xz

image/${RASPIOS_LITE_ARMHF_VERSION}.img.xz:
	@cd ./image/ ; \
	wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_armhf_latest'

image-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz:
	@cd ./image-raspios_lite_arm64/ ; \
	wget --continue --quiet --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_arm64_latest'

image-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz:
	@cd ./image-ubuntu_arm64 ; \
	wget --continue --quiet --trust-server-names 'https://cdimage.ubuntu.com/releases/22.04/release/${UBUNTU_SERVER_ARM64_VERSION}.img.xz'

armhf_clean:
	@sudo rm ./workspace-raspios/*.xz 2>/dev/null || true
	@sudo rm ./workspace-raspios/*.img 2>/dev/null || true

arm64_clean:
	@sudo rm ./workspace-raspios_lite_arm64/*.xz 2>/dev/null || true
	@sudo rm ./workspace-raspios_lite_arm64/*.img 2>/dev/null || true

ubuntu_clean:
	@sudo rm ./workspace-ubuntu_arm64/*.xz 2>/dev/null || true
	@sudo rm ./workspace-ubuntu_arm64/*.img 2>/dev/null || true

clean_images:
	@rm ./image*/*.xz 2>/dev/null || true

clean_workspaces: ubuntu_clean arm64_clean armhf_clean 

clean_all: clean_images clean_workspaces

workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img: | image/${RASPIOS_LITE_ARMHF_VERSION}.img.xz
	@sudo bash ./build_dist raspios

workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img.xz: | workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img
	@pv ./workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img | sudo xz > workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img.xz
	@sudo rm ./workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img

workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img: | image-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz
	@sudo bash ./build_dist raspios_lite_arm64 
workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz: | workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img
	@pv ./workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img | sudo xz > workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz
	@sudo rm ./workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img
	
workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img: | image-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz
	@sudo bash ./build_dist ubuntu_arm64 
workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz: | workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img
	@pv ./workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img | sudo xz > workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz
	@sudo rm ./workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img

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

.PHONY: clean_all clean_images clean_workspaces build_clean build_all ubuntu_clean arm64_clean armhf_clean release arm64 ubuntu armhf all

