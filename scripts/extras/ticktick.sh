#!/bin/bash
set -e
TICKTICK_VERSION="$(curl https://snapcraft.io/ticktick | grep stable | grep version | cut -d '"' -f 28)"
# shellcheck disable=SC2034
TARGET="https://d2atcrkye2ik4e.cloudfront.net/download/linux/linux_deb_x64/ticktick-$TICKTICK_VERSION-amd64.deb"
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb