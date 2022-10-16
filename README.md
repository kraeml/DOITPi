# DOITPi

Ist eine Pi-Distro um **D**ev**O**ps und **I**o**T** Tools auf dem **Pi** laufen zu lassen. Es binhaltete u.a.

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
