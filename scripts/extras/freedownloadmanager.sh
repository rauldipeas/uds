#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME='freedownloadmanager'
# shellcheck disable=SC2034
LN='freedownloadmanager'
# shellcheck disable=SC2034
SWMC='fdm'
# shellcheck disable=SC2034
TARGET="$(curl -sL https://www.freedownloadmanager.org/pt/download-fdm-for-linux.htm | grep deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC2034
ICON_OLD='/opt/freedownloadmanager/icon.png'
# shellcheck disable=SC2034
ICON_NEW='freedownloadmanager'
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
fix_launcher
install_deb
mkdir -p "$HOME"/.local/share/icons
cp /opt/freedownloadmanager/icon.png "$HOME"/.local/share/icons/freedownloadmanager.png