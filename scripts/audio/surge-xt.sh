#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sL https://api.github.com/repos/surge-synthesizer/releases-xt/releases | grep browser_download_url | grep deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb