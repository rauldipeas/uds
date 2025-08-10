#!/bin/bash
set -e
# shellcheck disable=SC2034
PPA='christian-boxdoerfer/fsearch-stable'
# shellcheck disable=SC2034
INSTNAME='fsearch'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
add_ppa
install_deb
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/gnome-search-tool.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/io.github.cboxdoerfer.FSearch.svg
fi