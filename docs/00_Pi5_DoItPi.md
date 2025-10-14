---
title: "Raspberry Pi 5 als DoItPi"
author: "Michael Schaar"
date: "2025-09-25"
subject: "Hardware trifft Open-Source-Konfiguration"
keywords: ["Raspberry Pi 5", "DevOps", "WLAN", "LTE", "Informatik", "DoItPi"]
lang: "de"
toc: true           # Inhaltsverzeichnis aktivieren
numbersections: true # Kapitelnummerierung einschalten
fontsize: 12pt      # Schriftgröße
mainfont: "JetBrainsMono Nerd Font" # Hauptschriftart (sofern installiert)
geometry: "a4paper"  # Seitenformat
linkcolor: "blue"    # Farbe der Hyperlinks
urlcolor: "blue"
---

# Raspberry Pi 5 als DoItPi – Hardware trifft Open-Source-Konfiguration

## Einleitung

Der **Raspberry Pi** ist seit 2012 nicht nur Lernplattform und Maker-Werkzeug, sondern zunehmend auch ein System für praxisnahe Ausbildung. Mit dem leistungsstarken **Raspberry Pi 5** rückt er noch näher an „echte“ Industrie- und IT-Systeme heran.  

Um den Pi wirklich *produktionsnah* zu nutzen, reicht die Hardware jedoch nicht aus. Hier setzt das Projekt **DoItPi** ([Projektseite](https://codeberg.org/kraeml/DOITPi)) an: Es bietet fertige **Konfigurationsskripte, Dokumentationen und praxisnahe Bauanleitungen**, um Raspberry-Pi-Systeme robust, wiederholbar und einsatzbereit zu machen.  

**Zielgruppen im Überblick:**  
- **Lehrkräfte:** DoItPi liefert reproduzierbare Setups für den Informatik- und Technikunterricht – weniger Zeit für Troubleshooting, mehr Zeit für Didaktik.  
- **Maker:** Flexible Bausteine, mit denen sich Projekte schneller realisieren lässt.  
- **Berufliche Bildung / Industrie:** Schüler und Auszubildende lernen praxisnah, wie dokumentierte Installationen Standard in der IT und Produktion sind.  

***

## Hardwarebasis: Raspberry Pi 5 im Überblick

Der Raspberry Pi 5 bietet erstmals PCIe, spürbar mehr Rechenleistung und moderne Peripherieanbindungen. Für DoItPi-Szenarien wichtig:  

- **CPU & RAM:** ARM Cortex-A76 bis 2,4 GHz, mit bis zu 8 GB RAM für anspruchsvollere Applikationen.  
- **PCIe-Slot:** Ermöglicht den Anschluss von NVMe-SSDs, ein Riesenschritt für Geschwindigkeit und Zuverlässigkeit.  
- **Neue Hardwaredetails:** On/Off-Schalter und RTC erleichtern den Betrieb im Unterricht und bei Projekten.  
- **Strombedarf:** Bis 20–25 Watt unter Last → stabile Versorgung ist Pflicht (DoItPi empfiehlt nur getestete Netzteile/UPS-Lösungen).  

***

## DoItPi: Der Software-Baukasten

Das Projekt DoItPi liefert **modulare Bausteine**, die auf den Raspberry Pi abgestimmt sind:  

- **Installationsskripte** für Standard-Setups (Datenlogger, kleine Server, Netzwerkknoten).  
- **Beispielkonfigurationen**: vorkonfigurierte Einstellungen für Netzwerk, NVMe, UPS und PCIe-HATs.  
- **Dokumentation**: nachvollziehbare Schritt-für-Schritt-Anleitungen – ideal für Unterricht und berufliche Schulungen.  
- **Community-Charakter:** Offenes Projekt, erweiterbar durch Maker und Lehrkräfte.  

### Mehrwert für Bildung
- Unterricht kann auf **fertigen Images** starten, statt Stunden mit Basisinstallation zu verlieren.  
- Lernende sehen sowohl die Hardwareseite (Pi & HATs) als auch die **Wertschöpfung durch Software-Standardisierung**.  
- Vergleich: „Klassischer Bastel-Pi“ vs. „DoItPi mit reproduzierbarem Setup“ – lehrreich im Hinblick auf professionelle Arbeitsweisen.  

***

## Typische DoItPi-Bausteine in der Praxis

### Speicher (NVMe vs. SD)
- DoItPi zeigt nicht nur „wie man’s anschließt“, sondern bietet Benchmarks und Konfigurations-Tipps.  
- Lernaufgabe im Unterricht: Unterschiede in Zugriffsgeschwindigkeit selbst messen.  

### Energieversorgung
- Über DoItPi können Schüler nachvollziehen, wie UPS-Lösungen eingebunden werden.  
- Didaktik-Idee: kleine Projektarbeit „Sicherer Betrieb bei Stromausfall“.  

### Netzwerk (WLAN, LTE)
- DoItPi dokumentiert stabile Treiber-Alternativen (Edimax, Quectel-Module).  
- Unterrichtsidee: „Baue deinen eigenen IoT-Knoten mit LTE und visualisiere die Daten“.  

***

## Lehr- und Ausbildungsszenarien mit DoItPi

- **Informatikunterricht:** Linux-Grundlagen, sicheres Arbeiten (SSH, Firewall), Unterschiede in Speichermedien.  
- **Elektrotechnik/Wirtschaftsschule:** Stromversorgung, Energiepufferung und ihre ökonomische Bedeutung.  
- **Maker-AGs:** Umweltmessstation mit DoItPi aufbauen (Sensorik + LTE + Dashboard).  
- **Berufliche Bildung (IT/Mechatronik):** realistische Übung zur **Konfigurationsverwaltung** (DoItPi als Einstieg in Themen wie Ansible, Docker & Infrastruktur-Automatisierung).  

***

## Warum DoItPi für Lehrkräfte und Maker überzeugt

- **Reduzierte Einstiegshürden:** Statt Treiberchaos – saubere Skripte und Images.  
- **Transfer in die Praxis:** Schüler entdecken, dass Dokumentation und Standardisierung essenzieller Bestandteil von Technikprojekten sind.  
- **Nachhaltigkeit:** Weniger Fehlkäufe und Frust → mehr tangible Ergebnisse im Unterricht.  
- **Maker-Vorteil:** Zeitersparnis + Inspiration für eigene Projekte in offener Community.  

***

## Fazit

Der Raspberry Pi 5 bildet die **Hardware-Grundlage**. DoItPi ergänzt ihn durch eine offene, praxisnahe **Software- und Konfigurationsbasis**, die ihn erst vollständig zum **Werkzeug für Lehre, Maker und Ausbildung** macht.  

Damit verwandelt sich der Pi vom „Bastelboard“ zum **Didaktik-Baustein für digitale und technische Bildung** – mit direkter Relevanz für Maker, Unterricht und berufliche Ausbildung.  
