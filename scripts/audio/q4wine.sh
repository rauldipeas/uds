#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='q4wine'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
sudo dpkg --add-architecture i386
sudo apt update
install_deb
if command -v q4wine >/dev/null; then
	xdg-mime default q4wine.desktop application/x-ms-dos-executable
	xdg-mime default q4wine.desktop application/x-msi
fi
if [ "$XDG_CURRENT_DESKTOP" == ubuntu:GNOME ]; then
	sudo apt install -y --reinstall qt5-gtk2-platformtheme qt5ct
	sudo tee /etc/profile.d/qt-qpa.sh >/dev/null <<EOF
export QT_QPA_PLATFORM=xcb
export QT_QPA_PLATFORMTHEME=qt5ct
EOF
	mkdir -p "$HOME"/.config/qt5ct
	tee "$HOME"/.config/qt5ct/qt5ct.conf >/dev/null <<EOF
[Appearance]
style=gtk2
EOF
fi