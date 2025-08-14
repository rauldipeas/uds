#!/bin/bash
set -e
# shellcheck disable=SC2034
# shellcheck disable=SC2034
INSTNAME='tuba'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
install_deb
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/mstdn.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/dev.geopjr.Tuba.svg
fi