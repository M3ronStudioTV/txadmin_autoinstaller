#!/bin/bash
# Ersteller Meron_Studio_TV v1.0

echo '--- FiveM Linux Installer (Systemd Version) ---'

systemctl stop fivem.service 2>/dev/null
apt update && apt upgrade -y
apt install xz-utils tar wget -y

mkdir -p /home/FiveM/server
cd /home/FiveM/server

echo 'Geben Sie den Link zu den FiveM-Artifakten ein (z.B. von https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/):'
read link
wget -O fx.tar.xz $link

echo 'Entpacken der FiveM-Dateien...'
tar xf fx.tar.xz
rm fx.tar.xz
echo 'Artifacts installiert.'

SERVICE_FILE="/etc/systemd/system/fivem.service"

if [ ! -f "$SERVICE_FILE" ]; then
    echo 'Erstelle systemd Service-Datei...'
    cat <<EOF > $SERVICE_FILE
[Unit]
Description=FiveM Server Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/home/FiveM/server
# Falls run.sh nicht existiert, wird oft direkt ld-musl-x86_64.so.1 mit proot gestartet
ExecStart=/bin/bash /home/FiveM/server/run.sh
Restart=on-failure
StandardOutput=append:/home/FiveM/server/cron.log
StandardError=inherit

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    systemctl enable fivem.service
    echo 'Service wurde registriert.'
fi

echo 'Starte FiveM Service...'
systemctl start fivem.service

echo 'Warte kurz auf den Serverstart, um Logs zu lesen...'
sleep 3
echo '--- Die letzten 20 Zeilen des Server-Logs: ---'
if [ -f "/home/FiveM/server/cron.log" ]; then
    tail -n 20 /home/FiveM/server/cron.log
else
    journalctl -u fivem.service -n 20 --no-pager
fi

echo "---------------------------------------------------------------------------------------------"
echo "-- ______  ___                        ____________       _____________      __________    __ "
echo "-- ___   |/  /__________________________  ___/_  /____  _______  /__(_)________  __/_ |  / / "
echo "-- __  /|_/ /_  _ \_  ___/  __ \_  __ \____ \_  __/  / / /  __  /__  /_  __ \_  /  __ | / /  "
echo "-- _  /  / / /  __/  /   / /_/ /  / / /___/ // /_ / /_/ // /_/ / _  / / /_/ /  /   __ |/ /   "	
echo "-- /_/  /_/  \___//_/    \____//_/ /_//____/ \__/ \__,_/ \__,_/  /_/  \____//_/    _____/    "
echo "---------------------------------------------------------------------------------------------"
echo "=========================================="
echo "Installation erfolgreich abgeschlossen!"
echo "=========================================="
