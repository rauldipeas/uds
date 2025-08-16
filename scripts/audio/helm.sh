#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="https://tytel.org$(curl -sSL https://tytel.org/helm/direct_downloads/ | grep deb | grep amd64 | cut -d '"' -f2)"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb