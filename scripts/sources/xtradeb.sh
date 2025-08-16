#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sL https://xtradeb.net/wiki/how-to-install-applications-from-this-web-site | grep Noble | grep deb | cut -d '"' -f2)"
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb