#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='celluloid'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
install_deb
grep -E '^(audio|video)/' /usr/share/mime/types | cut -d: -f1 |
    while IFS= read -r type; do
        xdg-mime default io.github.celluloid_player.Celluloid.desktop "$type"
    done