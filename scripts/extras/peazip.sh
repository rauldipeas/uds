#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sSL https://peazip.github.io/peazip-linux.html | grep GTK | grep deb | cut -d '"' -f2)"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb