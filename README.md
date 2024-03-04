# DOITPi

**D**ev**O**ps  
**I**o**T**  
**Pi** - RaspberryPi

Zugriff über Browser oder SSH.

| DevOps | IoT | Pi |
|--------|-----|----|
| - Kollaboration| - vernetzte Geräte | - Betriebssystem |
| - Automatisierung | - Smart Home | - Netzwerk |
| - Kontinuierliche Bereitstellung (CD/CI) | - Daten sammeln auswerten | - Headless Server |
| - Überwachung und Feedback | - Dashboard | - Backup |
| - Skalierbarkeit | - Automatisierung | - Power Supply |


[DOITPi][doitpi] ist eine DevOps-IoT-Toolsammlung auf Basis von Raspberry Pi OS Lite. Gebaut wird DOITPi mit Hilfe von [CustomPiOS][custompios].

## Themen

* Systemadministration

* Netzwerk

* Elektrotechnik

* Programmierung (Microcntroller)

## DevOps

* [Ansible][ansible]  
    Ansible konfiguriert Systeme, stellt Software bereit. Somit sind fortschrittliche IT-Aufgaben, wie kontinuierliche Bereitstellungen oder rollierende Updates, ohne Ausfallzeiten möglich.

* [testinfra][testinfra]  
    Mit Testinfra werden Unit-Tests in Python geschrieben, um den aktuellen Zustand eines Server zu testen, die mit Management-Tools wie Salt, Ansible, Puppet, Chef usw. konfiguriert wurden.

* [Codeserver][codeserver]  
    Führt VS Code auf dem Raspberry aus. Editiert wird über den Browser.

* [Etckeeper][etckeeper]

* LXC

* Docker

* Git

* Low Code

* Cockpit

* GitOps

* Proxmox

* [Cockpit][cockpit]  
    Cockpit ist eine webbasierte grafische Oberfläche für Server.

## IoT

* [IOTstack][iotstack]  
        IOTstack erstellt docker-compose Dateien, zur einfachen Erstellung und Wartung von IoT-Stacks auf dem Raspberry Pi.  
        Folgendes kann u.U. eingerichtet werden:

* [Node-Red][nodered]  
    Node-RED ist ein Programmierwerkzeug, mit dem sich Hardwaregeräte, APIs und Online-Dienste auf neue und interessante Weise miteinander verbinden lassen.

* [Heimdall][heimdall]  
    Heimdall Application Dashboard ist ein Dashboard für Webanwendungen. Es es nicht auf Anwendungen beschränkt, es können auch Weblinks zu allem hinzugefügt werden.

* [Eclipse Mosquitto][mosquitto]  
    Eclipse Mosquitto ist ein quelloffener Message Broker, der die MQTT-Protokollversionen 5.0, 3.1.1 und 3.1 implementiert. Mosquitto ist leichtgewichtig und eignet sich für den Einsatz auf allen Geräten, von stromsparenden Einplatinencomputern bis hin zu kompletten Servern.   

* Monitoring Dashboard
    * Telegraf
    * InfluxDB und 
    * Grafana
    * Prometheus

* Vernetzte Geräte nit Platform.io

    * Arduino
    * ESP
    * PI2040

* [ESP Home][esphome]  
    ESPHome ist ein System, mit dem ESP8266/ESP32 durch einfache, aber leistungsfähige Konfigurationsdateien (YAML) steuern und über Home Automation Systeme fernsteuern können.

Weitere Projekte die auf DoItPi aufbauen:

* Fischertechnik
    * frduino
    * ftswarm
    * TX-PI

* Solar für maker
    * libre.solar
    * MPPT
    * STM32

## Raspberry Pi

* Linux

* Netzwerke
    * LAN
    * WLAN
    * Hotspot
    * (P2P) VPN
    * Reverse Proxy
    * Letsencrypt

* Headless
    * SSH
    * Webdienste

* Backup

* Power Supply
    * USB-C Power Delivery
    * Powerbank
    * USV

* PiGPIO Dienste
    * pigpiod
    * Setup i2c and other
    * [Blockly-gPIo][blocklypi]

## Programmiersprachen/DSL

* Python

    * [Jupyter Lab][jupyterlab]  
        JupyterLab ist eine webbasierte interaktive Entwicklungsumgebung für Notebooks, Code und Daten. Die flexible Benutzeroberfläche ermöglicht es Benutzern, Arbeitsabläufe in den Bereichen Datenwissenschaft, wissenschaftliches Rechnen, Computerjournalismus und maschinelles Lernen zu konfigurieren und zu gestalten. Ein modulares Design lädt zu Erweiterungen ein, um die Funktionalität zu erweitern und zu bereichern.

    * virtualenv

* Bash Skripte

* YAML

* Golang

* Ruby/inspec.io

* JavaScript/node-red

* ...

## LowCode

* Blockly/Scratch

* node-red

* YAML

Unter [DOITPI Releas latest][doitpi-release] findet man das neuste Image.


[doitpi]: https://github.com/kraeml/doitpi
[doitpi-release]: https://github.com/kraeml/DOITPi/releases/latest
[codeserver]: https://github.com/coder/code-server
[ansible]: https://docs.ansible.com/ansible-core/devel/index.html
[testinfra]: https://testinfra.readthedocs.io/en/latest/index.html
[cockpit]: https://cockpit-project.org/
[autohotspot]: https://github.com/guysoft/CustomPiOS/blob/devel/src/modules/auto-hotspot/start_chroot_script
[blocklypi]: https://github.com/GrazerComputerClub/Blockly-gPIo
[custompios]: https://github.com/guysoft/CustomPiOS
[iotstack]: https://sensorsiot.github.io/IOTstack/
[nodered]: https://nodered.org/
[heimdall]: https://heimdall.site/
[mosquitto]: https://mosquitto.org/
[esphome]: https://esphome.io/
[jupyterlab]: http://jupyter.org/
[Etckeeper]: https://manpages.debian.org/bullseye/etckeeper/etckeeper.8.en.html

## Mitentwickeln?

**JAA**

### Anforderungen

* qemu-arm-static
* CustomPiOS
* Heruntergeladenes Raspbian-Image.
* root-Rechte für chroot
* Bash
* git
* sudo  
  (das Skript selbst ruft es auf. Als root, ohne sudo, wird nicht funktionieren)

### DOITPi in Raspbian/Debian/Ubuntu aus bauen

DOITPi kann in Debian, Ubuntu, Raspbian oder sogar in DOITPi aus gebaut werden. Die Erstellung erfordert etwa 2,5 GB freien Speicherplatz. Mit den folgenden Befehlen kann DOITPI gebaut werden:

```bash
sudo apt-get install gawk util-linux qemu-user-static git p7zip-full python3 coreutils

git clone https://github.com/guysoft/CustomPiOS.git
git clone https://github.com/kraeml/DOITPi.git
cd DOITPi/src/image
wget -c --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_armhf_latest'
cd ../image-raspios_lite_arm64
wget -c --trust-server-names 'https://downloads.raspberrypi.org/raspios_lite_arm64_latest'
cd ..
../../CustomPiOS/src/update-custompios-paths
sudo modprobe loop
sudo make build_arm64
```

__Code-Beiträge sind erwünscht!__


### ToDo Bauen mit Vagrant

Es gibt eine Vagrant-Maschinenkonfiguration, mit der DOITPi gebaut werden kann. Wenn Sie keine zusätzliche Konfiguration vornehmen, muss `vagrant` als `root` laufen, damit nfs folder sync funktioniert.

Vergewissern Sie sich, dass Sie eine Version von vagrant haben, die neuer als 1.9 ist! Wenn Sie ältere Versionen von Ubuntu/Debian verwenden und nicht `apt-get` von der Download-Seite verwenden.

Um `vagrant` auf Ubuntu zu benutzen:

```bash
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
```

Nach der Bereitstellung des Vagrant-Rechners ist es auch möglich, einen nächtlichen Build auszuführen, der Updates von devel verwendet:

```bash
cd DOITPi/src/vagrant
run_vagrant_build.sh
```

Um eine Variante auf der Maschine zu bauen, führen Sie einfach aus:

```bash
cd src/vagrant
run_vagrant_build.sh [Variante]
```
