#!/bin/bash
set -e
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
curl -s https://chowdsp.com/products.html | grep deb | grep -v ChowCentaur | grep -v ChowPhaser | cut -d '"' -f2 | xargs wget -q --show-progress
install_deb