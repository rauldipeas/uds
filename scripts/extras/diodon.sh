#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='diodon'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
install_deb
gsettings set net.launchpad.Diodon.clipboard add-images true
gsettings set net.launchpad.Diodon.clipboard recent-items-size 'uint32 18'