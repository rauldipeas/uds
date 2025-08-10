#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -s https://api.github.com/repos/magillos/Cable/releases | grep browser_download_url | grep deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb
mkdir -p "$HOME"/.config/{autostart,cable}
cat <<EOF | tee "$HOME"/.config/cable/config.ini >/dev/null
[DEFAULT]
tray_enabled = True
EOF
mkdir -p "$HOME"/.local/share/applications
cat <<EOF | tee "$HOME"/.local/share/applications/cables.desktop >/dev/null
[Desktop Entry]
Name=Cables
Exec=pw-jack cable %u
Icon=jack-plug
Terminal=false
Type=Application
StartupWMClass=connection-manager.py
NoDisplay=true
EOF
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/laditools.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/jack-plug.svg
fi