#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sL https://rclone.org/downloads | grep amd64.deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC2034
DEPS="rclone-browser"
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb