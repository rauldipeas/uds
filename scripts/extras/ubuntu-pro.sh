#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='ubuntu-advantage-tools'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
install_deb
sudo pro attach