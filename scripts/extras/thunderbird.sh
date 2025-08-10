#!/bin/bash
set -e
# shellcheck disable=SC2034
DEPS='thunderbird-locale-pt-br'
# shellcheck disable=SC2034
PPA='mozillateam/ppa'
# shellcheck disable=SC2034
INSTNAME='thunderbird-gnome-support'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
add_ppa
cat <<EOF | sudo tee /etc/apt/preferences.d/thunderbird
Package: thunderbird*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
install_deb