#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME="imagemagick\
     p7zip\
     zenity"
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
install_deb