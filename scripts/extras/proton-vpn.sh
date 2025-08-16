#!/bin/bash
set -e
PROTON_VPN_VERSION="$(curl -sL https://repo.protonvpn.com/debian/dists/stable/main/binary-all/ | grep -oP 'protonvpn-stable-release_\K[0-9.]+(?=_all\.deb)' | sort -V | tail -n1)"
# shellcheck disable=SC2034
TARGET="$(printf "%s" https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_"${PROTON_VPN_VERSION}"_all.deb)"
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb
sudo apt update
sudo apt install -y --reinstall proton-vpn-gnome-desktop