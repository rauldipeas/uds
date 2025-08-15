#!/bin/bash
set -e
pipx install spotdl

mkdir -p "$HOME"/.local/share/{applications,icons}
wget -q --show-progress -O "$HOME"/.local/share/icons/spotdl.png https://user-images.githubusercontent.com/19922556/111814897-214b8e00-892f-11eb-9a2a-f1fca329e4d2.png
tee "$HOME"/.local/share/applications/spotdl.desktop >/dev/null <<EOF
[Desktop Entry]
Type=Application
Name=SpotDL
Icon=spotdl
Exec=spotdl web
Terminal=false
EOF
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/wihotspot.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/spotdl.svg
fi