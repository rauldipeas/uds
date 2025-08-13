#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -s https://api.github.com/repos/syncthing/syncthing/releases | grep browser_download_url | grep amd64.deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb
#sudo systemctl enable syncthing@"$USER".service
#sudo systemctl start syncthing@"$USER".service