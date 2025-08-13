#!/bin/bash
set -e
# shellcheck disable=SC2034
DEPS='python3-wxgtk4.0'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
install_deb
pipx install --force superpaper --system-site-packages
mkdir -p "$HOME"/.local/share/{applications,icons}
ln -fs "$HOME"/.local/share/pipx/venvs/superpaper/share/icons/hicolor/256x256/apps/superpaper.png "$HOME"/.local/share/icons/
cat <<EOF | tee "$HOME"/.local/share/applications/superpaper.desktop >/dev/null
[Desktop Entry]
Type=Application
Version=1.0
Name=Superpaper
GenericName=Multi-monitor wallpaper manager
Exec=env GDK_BACKEND=x11 /home/$USER/.local/bin/superpaper
Icon=superpaper
Terminal=false
Categories=Utility; 
X-KDE-autostart-after=panel
EOF
mkdir -p "$HOME"/.config/autostart
ln -sf "$HOME"/.local/share/applications/superpaper.desktop "$HOME"/.config/autostart/