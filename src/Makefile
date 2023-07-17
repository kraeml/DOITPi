build:
	sudo bash ./build_dist raspios

build_arm64:
	sudo bash ./build_dist raspios_lite_arm64

build_ubuntu:
	sudo bash ./build_dist ubuntu_arm64

# Falls github CD/CI dann noch .github/build.yml anpassen, falls build_ubuntu oder build
build_all: build_arm64 build
