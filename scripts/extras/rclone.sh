#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sSL https://rclone.org/downloads | grep amd64.deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC2034
DEPS="rclone-browser"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb