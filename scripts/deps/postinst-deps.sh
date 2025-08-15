#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME="curl\
     imagemagick\
     p7zip\
     zenity"
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
install_deb