#!/bin/bash
set -e
# shellcheck disable=SC2034
DEPS="libxdo3"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
install_deb
pacstall -IP rustdesk-deb