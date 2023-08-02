build:
	sudo rm workspace-raspios/*.xz
	sudo bash ./build_dist raspios
	sudo xz workspace-raspios/*.img

build_arm64:
	sudo rm workspace-raspios_lite_arm64/*.xz
	sudo bash ./build_dist raspios_lite_arm64
	sudo xz workspace-raspios_lite_arm64/*.img

build_ubuntu:
	sudo rm workspace-ubuntu_arm64/*.xz
	sudo bash ./build_dist ubuntu_arm64
	sudo xz workspace-ubuntu_arm64/*.img

build_all: build_ubuntu build_arm64 build

release:
	release=$$(grep VERSION ../CHANGELOG.md | head -n 1 | cut -d '=' -f 2); \
	git flow release start v${release}; \
	sed -i 's@DIST_VERSION=v.*@DIST_VERSION=v'$${release}'@g' config; \
	major=$$(echo "$${release}" | awk -F"." '{print $$1}'); \
	minor=$$(echo "$${release}" | awk -F"." '{print $$2}'); \
	patch=$$(echo "$${release}" | awk -F"." '{print $$3}'); \
	new_patch=$$(echo "$$patch + 1" | bc); \
	new_version="$$major.$$minor.$$new_patch"; \
	sed -i '1s/^/VERSION='$$new_version'\n- [ ] \n/' ../CHANGELOG.md

