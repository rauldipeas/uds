#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sSL https://api.github.com/repos/Milkshiift/GoofCord/releases | grep browser_download_url | grep amd64.deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/discord.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/goofcord.svg
fi