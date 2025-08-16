#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sSL https://api.github.com/repos/Dimethoxy/Disflux/releases | grep browser_download_url | grep download | grep ubuntu.deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb
mkdir -p /tmp/dimethoxy
cd /tmp/dimethoxy
rm -f /tmp/dimethoxy/*.zip
wget -q --show-progres "$(curl -sSL https://api.github.com/repos/Dimethoxy/Plasma/releases | grep browser_download_url | grep download | grep linux.tar.gz | head -n1 | cut -d '"' -f4)"
tar -xf plasma*.tar.gz
mkdir -p "$HOME"/.vst3
find "$PWD" -type d -name '*.vst3' -exec cp -r '{}' "$HOME"/.vst3/ \;