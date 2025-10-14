---
title: "Raspberry Pi: Installation eines benutzerdefinierten Images"  # Titel des Dokuments
author: "Michael Schaar"  # Autor:innenangabe
date: "2025-10-13"        # Aktualisiertes Datum (heute)
subject: "Technische Anleitung für Raspberry Pi mit DOITPi-Image"  # Thema/Kontext
keywords:                  # Suchbegriffe für die Dokumentation
  - Raspberry Pi
  - DOITPi
  - microSD-Karte
  - SSH
  - WLAN-Konfiguration
  - GitHub-Artifacts
lang: "de"                 # Sprache: Deutsch
toc: true                  # Inhaltsverzeichnis aktivieren
numbersections: true       # Kapitelnummerierung (1., 1.1, 1.2, ...)
fontsize: 12pt             # Schriftgröße
mainfont: "DejaVu Sans"     # Hauptschriftart (gut lesbar)
monofont: "JetBrains Mono"  # Schriftart für Code/Terminal-Beispiele
geometry: "a4paper, margin=2.5cm"  # Seitenformat (DIN A4, 2,5 cm Rand)
linkcolor: "blue"          # Farbe für Hyperlinks
urlcolor: "blue"            # Farbe für URLs
---

# **Raspberry Pi: Vorgefertigtes Image installieren und konfigurieren**

**Ziel:** Diese Anleitung führt dich Schritt für Schritt durch die Installation eines vorkonfigurierten Raspberry Pi-Images – von Download bis zum ersten Start. **Alle Einstellungen (Hostname, WLAN, SSH, Sprache, Tastatur, Zeitzone) werden direkt im Raspberry Pi Imager vorgenommen.**  
**Zielgruppe:** Kurs-Teilnehmende und Einsteiger:innen mit Grundkenntnissen.

* * *

## WICHTIGER HINWEIS: DATENVERLUST AUF DER SD-KARTE!

**Bevor du fortfährst:**

- **Alle Daten auf der ausgewählten microSD-Karte werden unwiderruflich gelöscht!**
- **Sichere alle wichtigen Dateien** von der Karte, falls vorhanden.
- **Stelle sicher, dass du die richtige Karte ausgewählt hast** – der Raspberry Pi Imager zeigt dir den **genauen Namen und die Größe** der Karte an (z. B. `SanDisk Ultra 32GB`).
- **Verwende keine Karte mit persönlichen Daten** – nutze ausschließlich eine **leere oder speziell für den Pi vorgesehene Karte**.

**Beispiel im Imager:**  
Wenn du im Raspberry Pi Imager eine Karte mit dem Namen **"SanDisk Ultra 32GB**" auswählst, wird **alles auf dieser Karte gelöscht** – auch Fotos, Dokumente oder andere Projekte!

* * *

## Voraussetzungen

**Hardware:**

- microSD-Karte (**mind. 32 GB**, empfohlen: *SanDisk Ultra A1* oder *Samsung EVO Plus*).
- Raspberry Pi (kompatibles Modell: Pi 3/4/5 oder Zero 2 W).
- PC/Laptop mit **Kartenleser** und Internetzugang.

**Software:**

- [Raspberry Pi Imager (offiziell)](https://www.raspberrypi.com/software/).
- **Entpack-Tool** (z. B. 7-Zip, WinRAR, macOS Finder).

* * *

## Image herunterladen und entpacken

Lade das Image von GitHub herunter:

[DOITPi Image (latest release)](https://github.com/kraeml/DOITPi/releases/latest)

1.  Öffne den Link und lade das **ZIP-Artifact** herunter (ggf. GitHub-Login erforderlich).
2.  **Entpacke die ZIP-Datei** – es entsteht eine `.img`\-Datei (z. B. `doitpi.img`).  
    **Wichtiger Hinweis:** Notiere den **Speicherort** der `.img`\-Datei.

* * *

## Raspberry Pi Imager installieren und starten

1.  Lade den Imager von der [offiziellen Website](https://www.raspberrypi.com/software/) herunter.
2.  Installiere und starte das Programm.

* * *

## Image auf microSD-Karte schreiben & konfigurieren

Siehe auch: https://www.raspberrypi.com/documentation/computers/getting-started.html#installing-the-operating-system

**Schritt 1:** Lege die microSD-Karte in den PC ein.

**Schritt 2:** Im Imager:

- Klicke auf **"Betriebssystem wählen"** → **"Benutzerdefiniertes Image verwenden"** → Wähle die `.img`\-Datei.
- Klicke auf **"Speicher wählen"** → Wähle die microSD-Karte.

**Schritt 3:** **Drücke `Strg + Shift + X`**, um die **erweiterten Einstellungen** zu öffnen.

* * *

## Erweiterte Einstellungen festlegen

Siehe auch: https://www.raspberrypi.com/documentation/computers/getting-started.html#advanced-options

Hier werden **alle Konfigurationen** vor dem Schreiben gesetzt:

| **Einstellung** | **Wert** | **Hinweis** |
| --- | --- | --- |
| **Hostname** | `piXY` (z. B. `pi01`) | `XY` = Kursnummer. |
| **Benutzername** | Individuell (z. B. `pi`) | **Nicht** `pi` + `raspberry` belassen! |
| **Passwort** | **Sicheres Passwort** | Mind. 8 Zeichen, Sonderzeichen verwenden. |
| **SSH aktivieren** |  Häkchen setzen | **Unbedingt aktivieren!** |
| **WLAN** | SSID + Passwort | Land: `DE` (Deutschland). |
| **Zeitzone** | `Europe/Berlin` |     |
| **Tastaturlayout** | `de` (Deutsch) |     |
| **Sprache** | `de_DE.UTF-8` |     |

**Bestätige mit "Speichern".**

* * *

## Image schreiben

1.  Klicke auf **"Schreiben"**.
2.  **Warte ab**, bis der Vorgang abgeschlossen ist (Dauer: 10–30 Minuten).  
    **Warnung:** Unterbreche den Prozess **nicht**!

* * *

## Raspberry Pi starten & verbinden

Siehe auch: https://www.raspberrypi.com/documentation/computers/getting-started.html#set-up-your-raspberry-pi

1.  Stecke die microSD-Karte in den Pi.
2.  **Stromversorgung anschließen** – der Pi startet automatisch.
3.  **Warte 1–2 Minuten**, bis der Pi hochgefahren ist.

* * *

## Verbindung per SSH herstellen

Öffne ein Terminal (Linux/macOS) oder **PuTTY** (Windows) und verbinde dich:

```bash
ssh pi@piXY.local  # Beispiel: ssh pi@pi01.local
```

- **Benutzername:** Dein gewählter Name (Standard: `pi`).
- **Passwort:** Das von dir gesetzte Passwort.

** Tipp:** Falls die Verbindung scheitert:

- Prüfe die **Netzwerkverbindung** (`ping piXY.local`).
- Kontrolliere, ob **SSH aktiviert** wurde.

* * *

## Erste Schritte: System aktualisieren

Führe **sofort** nach dem Login ein Update durch:

```bash
sudo apt update && sudo apt full-upgrade -y
sudo reboot  # Neustart, um Änderungen zu übernehmen.
```

* * *

## 10\. Fehlerbehebung

[Apply Sorting!](#)

| **Problem** | **Lösung** |
| --- | --- |
| **Keine SSH-Verbindung** | \- Pi neu starten.  <br>\- SSH-Einstellungen prüfen (`Strg+Shift+X`). |
| **Kein WLAN** | \- SSID/Passwort auf Tippfehler prüfen.  <br>\- Land auf `DE` setzen. |
| **Pi startet nicht** | \- microSD-Karte neu beschreiben.  <br>\- Stromversorgung prüfen. |

* * *

## 11\. Sicherheitshinweise

- **Passwort ändern** (falls noch nicht geschehen):
    
    ```bash
    passwd
    ```
    
- **SSH absichern:**
    
    - Schlüsselbasierte Authentifizierung einrichten (optional).
    - Standard-Port 22 ändern (für Fortgeschrittene).
- **Regelmäßige Updates:**
    
    ```bash
    sudo apt update && sudo apt full-upgrade -y
    ```
    

* * *

## 12\. Nützliche Ressourcen

- [Raspberry Pi Imager – Offizielle Doku](https://www.raspberrypi.com/documentation/computers/getting-started.html)
- [GitHub Artifacts – Download-Hilfe](https://docs.github.com/actions/managing-workflow-runs/downloading-workflow-artifacts)
- [SSH unter Windows (PuTTY)](https://www.chiark.greenend.org.uk/~sgtatham/putty/)
- [Kleine putty Anleigung für Anfänger](https://bits-meet-bytes.de/kleine-putty-anleitung-fuer-einsteiger)

* * *

**Fertig!** Dein Raspberry Pi ist jetzt einsatzbereit und für den Kurs **einheitlich konfiguriert**.
