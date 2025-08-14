#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME='thunderbird'
# shellcheck disable=SC2034
LN='thunderbird'
# shellcheck disable=SC2034
EXEC_OLD='thunderbird'
# shellcheck disable=SC2034
EXEC_NEW='env GDK_BACKEND=x11 thunderbird'
# shellcheck disable=SC2034
DEPS='systray-x-gnome thunderbird-locale-pt-br'
# shellcheck disable=SC2034
PPA='mozillateam/ppa'
# shellcheck disable=SC2034
INSTNAME='thunderbird-gnome-support'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
wget -qO- https://download.opensuse.org/repositories/home:/Ximi1970/xUbuntu_24.04/Release.key | sudo tee /etc/apt/trusted.gpg.d/Systray-x.Ximi1970.asc >/dev/null
printf 'deb https://download.opensuse.org/repositories/home:/Ximi1970:/Mozilla:/Add-ons/xUbuntu_24.04 ./' | sudo tee /etc/apt/sources.list.d/systray-x.list >/dev/null
sudo apt update
add_ppa
sudo tee /etc/apt/preferences.d/thunderbird >/dev/null <<EOF
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
fix_launcher
install_deb