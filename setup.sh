#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
ZIP_FILE_NAME="multiping.zip"
ZIP_FILE_PATH="$SCRIPT_DIR/$ZIP_FILE_NAME"
DESTINATION_DIR="$SCRIPT_DIR/multiping"

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

if [ ! -f "$ZIP_FILE_PATH" ]; then
  echo "Error: $ZIP_FILE_NAME does not exist in $SCRIPT_DIR"
  exit 1
fi

echo "Unzipping $ZIP_FILE_NAME to $DESTINATION_DIR..."
mkdir -p "$DESTINATION_DIR"
unzip -o "$ZIP_FILE_PATH" -d "$DESTINATION_DIR"

echo "Installing necessary applications..."
apt-get update
apt-get install -y sqlite3 python3 python3-pip
pip3 install flask

SERVICE_FILE="/etc/systemd/system/multiping.service"

cat << EOF > "$SERVICE_FILE"
[Unit]
Description=MultiPing Service

[Service]
ExecStart=/usr/bin/python3 $DESTINATION_DIR/app.py
WorkingDirectory=$DESTINATION_DIR
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl enable multiping.service
systemctl start multiping.service

echo "MultiPing setup is complete."
