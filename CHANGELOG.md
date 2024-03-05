VERSION=0.4.9

   - [x] Pyenv für Standarduser
   - [x] Testinfra tests über doitpi-test

VERSION=0.4.8

- mybase mit ansible
- Codeserver automatisch auf neuster Version

VERSION=0.4.7

- [x] Grafana für armhf und arm64 unterschiedlich, hotfix build ging nicht

Version=0.4.6-1
- [x] Grafana für arm64 10.1.5
- [x] Grafana für armhf 10.1.2

VERSION=0.4.6

- [x] Prometheus 2.47.1
- [x] Grafana 10.1.5
- [x] RaspianOs bookworm
- [x] Codeserver Version v4.17.1
- [x] autohotspot einrichten
   - [x] Auto-Hotspot  
      Dies ist ein Modul, das Ihre Himbeere zu einem WLAN-Hotspot macht, wenn sich das WLAN nicht mit einem Netzwerk verbindet. Wenn ein Ethernet-Kabel angeschlossen ist, leitet es die Verbindung weiter. Ursprünglich auf dieser Anleitung. Muss in einem disable-servicesModulblock.

   
VERSION=0.4.5

- [x] Coderserver Version v4.16.0
- [x] Ubuntu
- [x] Workflow mit Artifakten
- [x] Mit Release

VERSION=0.4.4

- [ ] Ubuntu (Geht wegen docker nicht)
- [x] Prometheus
- [x] Grafana

```bash
   sudo apt update
   wget https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-arm64.tar.gz
   tar xfz prometheus-2.45.0.linux-arm64.tar.gz
   rm prometheus-2.45.0.linux-arm64.tar.gz 
   mv prometheus-2.45.0.linux-arm64/ prometheus

   sudo vi /etc/systemd/system/prometheus.service

   cat /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=michl
Restart=on-failure

#Change this line if Prometheus is somewhere different
ExecStart=/home/michl/prometheus/prometheus \
  --config.file=/home/michl/prometheus/prometheus.yml \
  --storage.tsdb.path=/home/michl/prometheus/data

[Install]
WantedBy=multi-user.target

   sudo systemctl daemon-reload 
   sudo systemctl start prometheus.service 
   sudo systemctl status prometheus.service
   sudo systemctl enable prometheus.service 
# ToDo Link von localhost:9090 nicht auf FQDN
   sudo vi /etc/hosts
   hostname -f
# ToDo End
   sudo apt-get install -y adduser libfontconfig1
   wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.0.3_arm64.deb
   sudo dpkg -i grafana-enterprise_10.0.3_arm64.deb
   sudo systemctl start grafana-server.service 
   sudo systemctl status grafana-server.service 
   sudo systemctl enable grafana-server.service
```

* Umstrukturierung des Github-Workflows

VERSION=0.4.3
* Build auf master

VERSION=0.4.2
* Build workflow angepasst

VERSION=0.4.1
* Mit armhf

VERSION=0.4.0
* Neue Basis Images 2023-05-03 raspios und ubuntu22.0.4.2

VERSION=0.3.2-4
* Ohne Base Distro respianos
* Build mit raspios Verzeichnis
* Ohne cockpit wegen ubuntu User
* Ubuntu ohne pigpio
* Build mit ubuntu arm64 copy
* Build mit ubuntu im Imagenamen.
* Neue Build API
* Ubuntu Build komplett mit raspbianos
* Rollback build assert v1


VERSION=0.2.11
* Jupyter PW foowashere
* codeserver in Version 4.9.1
* raspianos (armhf) ohne Docker (Workaround da rust nicht aktuell für arm32)

VERSION=0.2.10
* Thonny inatalliert und als regular View eingerichtet
* codeserver in Version 4.9.0
