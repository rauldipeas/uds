#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -s https://api.github.com/repos/Gisto/Gisto/releases | grep browser_download_url | grep .deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/gisto.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/Gisto.svg
fi