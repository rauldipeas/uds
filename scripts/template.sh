#!/bin/bash
set -e
BASENAME=''
LN=''
SWMC=''
TARGET="$()"
EXEC_OLD=''
EXEC_NEW=''
ICON_OLD=''
ICON_NEW=''
DEPS=""
PPA=''
INSTNAME=''
BASENAME2=''
LN2=''
SWMC2=''
EXEC_OLD2=''
EXEC_NEW2=''
ICON_OLD2=''
ICON_NEW2=''
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
add_ppa
fix_launcher
install_deb
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
    COMANDO_UBUNTU
elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
    COMANDO_DEBIAN
fi
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/"$ICON_ORIG".svg "$HOME"/.icons/Papirus-Dark/64x64/apps/"$ICON_REPL".svg
fi