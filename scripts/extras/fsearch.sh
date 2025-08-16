#!/bin/bash
set -e
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
    # shellcheck disable=SC2034
    PPA='christian-boxdoerfer/fsearch-stable'
fi
# shellcheck disable=SC2034
INSTNAME='fsearch'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
    add_ppa
fi
install_deb
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/gnome-search-tool.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/io.github.cboxdoerfer.FSearch.svg
fi