#!/bin/bash
set -e
# shellcheck disable=SC2034
PPA='costales/folder-color'
# shellcheck disable=SC2034
INSTNAME='folder-color'
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
add_ppa
install_deb