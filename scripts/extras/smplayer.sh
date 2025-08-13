#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='smplayer'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
install_deb
grep -E '^(audio|video)/' /usr/share/mime/types | cut -d: -f1 |
    while IFS= read -r type; do
        xdg-mime default smplayer.desktop "$type"
    done