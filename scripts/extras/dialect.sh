#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='dialect'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
install_deb
dconf reset -f /app/drey/Dialect/
dconf write /app/drey/Dialect/translators/google/dest-langs "['pt', 'es', 'de', 'en']"
dconf write /app/drey/Dialect/translators/google/init true