MAKEFLAGS+="-j -l 2"

RASPIOS_LITE_ARMHF_VERSION = 2023-05-03-raspios-bullseye-armhf-lite
RASPIOS_LITE_ARM64_VERSION = 2023-05-03-raspios-bullseye-arm64-lite
UBUNTU_SERVER_ARM64_VERSION = ubuntu-22.04.2-preinstalled-server-arm64+raspi



pwd:
	cd ./image
	pwd

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
	@sudo rm workspace-raspios/*.xz 2>/dev/null || true

arm64_clean:
	@sudo rm workspace-raspios_lite_arm64/*.xz 2>/dev/null || true

ubuntu_clean:
	@sudo rm workspace-ubuntu_arm64/*.xz 2>/dev/null || true

clean_all: ubuntu_clean arm64_clean armhf_clean

workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img.xz: image/${RASPIOS_LITE_ARMHF_VERSION}.img.xz
	sudo bash ./build_dist raspios
	sudo xz workspace-raspios/*.img

workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz: image-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz
	sudo bash ./build_dist raspios_lite_arm64
	sudo xz workspace-raspios_lite_arm64/*.img
	

workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz: image-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz
	sudo bash ./build_dist ubuntu_arm64
	sudo xz workspace-ubuntu_arm64/*.img

build_all: workspace-ubuntu_arm64/${UBUNTU_SERVER_ARM64_VERSION}.img.xz workspace-raspios_lite_arm64/${RASPIOS_LITE_ARM64_VERSION}.img.xz workspace-raspios/${RASPIOS_LITE_ARMHF_VERSION}.img.xz

build_clean: clean_all build_all

.PHONY: build_clean build_all ubuntu_clean arm64_clean armhf_clean

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

