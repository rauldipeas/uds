#!/bin/bash
set -e
# shellcheck disable=SC2034
PPA='obsproject/obs-studio'
# shellcheck disable=SC2034
INSTNAME='obs-studio'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
add_ppa
install_deb