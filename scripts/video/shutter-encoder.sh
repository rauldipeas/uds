#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME='shutter-encoder'
# shellcheck disable=SC2034
LN='Shutter_Encoder'
# shellcheck disable=SC2034
SWMC='application-Shutter'
# shellcheck disable=SC2034
versao=$(curl -sL 'https://www.shutterencoder.com/old%20versions/Linux/'|grep -Po 'Shutter Encoder \K[0-9]+\.[0-9]+'|sort -V | tail -1)
IFS=. read -r major minor <<< "$versao"
minor=$((minor + 1))
# shellcheck disable=SC2034
TARGET="https://www.shutterencoder.com/Shutter%20Encoder%20${major}.${minor}%20Linux%2064bits.deb"
# shellcheck disable=SC2034
ICON_OLD='/usr/lib/Shutter\ Encoder/usr/bin/icon.png'
# shellcheck disable=SC2034
ICON_NEW='shutter-encoder'
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
fix_launcher
mv /tmp/Shutter*.deb /tmp/shutter-encoder.deb
install_deb
mkdir -p "$HOME"/.local/share/icons
ln -sf /usr/lib/Shutter\ Encoder/usr/bin/icon.png "$HOME"/.local/share/icons/shutter-encoder.png