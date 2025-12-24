```md
# FiveM Linux Installer (Systemd Version)

Ein automatisiertes **Bash-Installationsskript** zur einfachen Einrichtung eines **FiveM Servers auf Linux (Ubuntu/Debian)** inklusive **systemd-Service** für automatischen Start und Überwachung.

Erstellt von **Meron_Studio_TV – v1.0**

---

## 📌 Features

- ✅ Automatische Installation aller benötigten Pakete
- ✅ Download und Entpacken von FiveM Artifacts
- ✅ Einrichtung eines systemd-Services (`fivem.service`)
- ✅ Automatischer Serverstart beim Booten
- ✅ Log-Ausgabe per Datei oder `journalctl`
- ✅ Ideal für VPS & Dedicated Server

---

## 🖥️ Unterstützte Systeme

Getestet und empfohlen für:

- Ubuntu 20.04 / 22.04
- Debian 10 / 11 / 12

> ⚠️ Root-Zugriff ist erforderlich.

---

## 📂 Verzeichnisstruktur

Nach der Installation wird folgende Struktur verwendet:

```

/home/FiveM/server
├── run.sh
├── alpine/
├── citizen/
├── cron.log
└── weitere FiveM-Dateien

````

Der systemd-Service wird aus diesem Verzeichnis gestartet.

---

## ⚙️ Voraussetzungen

- Root- oder sudo-Zugriff
- Aktive Internetverbindung

Empfohlen:

```bash
sudo -i
````

---

## 🚀 Installation

### 1️⃣ Repository klonen oder Script herunterladen

```bash
git clone https://github.com/DEINNAME/fivem-linux-installer.git
cd fivem-linux-installer
```

oder direkt:

```bash
wget https://raw.githubusercontent.com/DEINNAME/fivem-linux-installer/main/install.sh
chmod +x install.sh
```

---

### 2️⃣ Installer ausführen

```bash
./install.sh
```

---

### 3️⃣ FiveM Artifact Link eingeben

Während der Installation wirst du aufgefordert, einen **direkten Download-Link** zu den FiveM Artifacts einzugeben.

Beispiel:

```
https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/XXXX-XXXX/fx.tar.xz
```

➡️ Aktuelle Artifacts findest du hier:
[https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/](https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/)

---

## 🔄 Systemd Service

Nach der Installation wird automatisch folgender Service erstellt:

* **Name:** `fivem.service`
* **Pfad:** `/etc/systemd/system/fivem.service`

### Service-Befehle

```bash
systemctl start fivem.service
systemctl stop fivem.service
systemctl restart fivem.service
systemctl status fivem.service
```

Der Service ist automatisch für den Systemstart aktiviert.

---

## 📜 Logs einsehen

### Logdatei

```bash
tail -f /home/FiveM/server/cron.log
```

### Systemd Journal

```bash
journalctl -u fivem.service -f
```

---

## ❗ Wichtige Hinweise

* Das Script installiert **nur den FiveM Server**
* Ressourcen und `server.cfg` müssen selbst eingerichtet werden
* Stelle sicher, dass:

  * `run.sh` vorhanden ist
  * dein `server.cfg` korrekt konfiguriert ist
* Standard-Port `30120` muss in der Firewall freigegeben sein

---

## 🔐 Sicherheitsempfehlung

Für produktive Umgebungen wird empfohlen:

* FiveM **nicht als root** laufen zu lassen
* Einen eigenen Benutzer (z. B. `fivem`) zu erstellen
* Firewall (UFW) zu aktivieren

---

## 🛠️ Fehlerbehebung

### Service startet nicht

```bash
journalctl -u fivem.service -n 50 --no-pager
```

### `run.sh` fehlt

* Artifact-Link prüfen
* Neu herunterladen und entpacken

---

## 📄 Lizenz

Dieses Projekt steht unter der **MIT License**.
Freie Nutzung, Bearbeitung und Weitergabe erlaubt.

---

## ❤️ Credits

* FiveM Team – [https://fivem.net](https://fivem.net)
* Installer-Script von **Meron_Studio_TV**

---

## ⭐ Support

Wenn dir dieses Projekt hilft, hinterlasse gerne einen ⭐ auf GitHub.

Probleme oder Vorschläge?

* Issue eröffnen
* Pull Request senden

```
```
