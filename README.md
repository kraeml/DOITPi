# DOITPi

Ist eine Pi-Distro um **D**ev**O**ps und **I**o**T** Tools auf dem **Pi** laufen zu lassen. Es beinhaltet u.a.

* [Codeserver][codeserver]  
    Run VS Code on any machine anywhere and access it in the browser.
* [Ansible][ansible]  
    It can configure systems, deploy software, and orchestrate more advanced IT tasks such as continuous deployments or zero downtime rolling updates.
* [testinfra][testinfra]  
    With Testinfra you can write unit tests in Python to test actual state of your servers configured by management tools like Salt, Ansible, Puppet, Chef and so on.
* LXC
* Docker
* [Cockpit][cockpit]  
    Cockpit is a web-based graphical interface for servers, intended for everyone...
* [autohotspot][autohotspot]  
    Script sets up an automatic hotspot if no wifi is found.
* PiGPIO Dienste
    * pigpiod
    * Setup i2c and other
    * [Blockly-gPIo][blocklypi]
* MCU Development
    * platformio
* Python
    * Jupyter
    * virtualenv

DevOpsPiOS baut auf [CustomPiOS][custompios].

[codeserver]: https://github.com/coder/code-server
[ansible]: https://docs.ansible.com/ansible-core/devel/index.html
[testinfra]: https://testinfra.readthedocs.io/en/latest/index.html
[cockpit]: https://cockpit-project.org/
[autohotspot]: https://github.com/guysoft/CustomPiOS/blob/devel/src/modules/auto-hotspot/start_chroot_script
[blocklypi]: https://github.com/GrazerComputerClub/Blockly-gPIo
[custompios]: https://github.com/guysoft/CustomPiOS

## Developing

### Requirements

* qemu-arm-static
* CustomPiOS
* Downloaded Raspbian image.
* root privileges for chroot
* Bash
* git
* sudo (the script itself calls it, running as root without sudo won't work)

### Build DOITPi From within Raspbian / Debian / Ubuntu

DOITPi can be built from Debian, Ubuntu, Raspbian, or even DOITPi. Build requires about 2.5 GB of free space available. You can build it by issuing the following commands:

sudo apt-get install gawk util-linux qemu-user-static git p7zip-full python3

git clone https://github.com/guysoft/CustomPiOS.git
git clone https://github.com/kraeml/DOITPi.git
cd DOITPi/src/image
wget -c --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_armhf_latest'
cd ..
../../CustomPiOS/src/update-custompios-paths
sudo modprobe loop
sudo bash -x ./build_dist

### Building Using Vagrant

There is a vagrant machine configuration to let build DOITPi in case your build environment behaves differently. Unless you do extra configuration, vagrant must run as root to have nfs folder sync working.

Make sure you have a version of vagrant later than 1.9!

If you are using older versions of Ubuntu/Debian and not using apt-get from the download page.

To use it:

sudo apt-get install vagrant nfs-kernel-server virtualbox
sudo vagrant plugin install vagrant-nfs_guest
sudo modprobe nfs
cd ../DOITPi
git clone https://github.com/guysoft/CustomPiOS.git
cd DOITPi/src
../../CustomPiOS/src/update-custompios-paths
cd DOITPi/src/vagrant
sudo vagrant up
run_vagrant_build.sh

After provisioning the machine, its also possible to run a nightly build which updates from devel using:

cd DOITPi/src/vagrant
run_vagrant_build.sh

To build a variant on the machine simply run:

cd src/vagrant
run_vagrant_build.sh [Variant]

### Usage

    If needed, override existing config settings by creating a new file src/config.local. You can override all settings found in src/modules/DOITPi/config. If you need to override the path to the Raspbian image to use for building DOITPi, override the path to be used in ZIP_IMG. By default the most recent file matching *-raspbian.zip found in src/image will be used.
    Run src/build_dist as root.
    The final image will be created at the src/workspace

Code contribution would be appreciated!