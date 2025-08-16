#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME='retroarch'
# shellcheck disable=SC2034
LN='retroarch-AM'
# shellcheck disable=SC2034
SWMC='com.libretro.RetroArch'
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
fix_launcher
am -i --icons retroarch
sudo bash /usr/local/share/custom-launchers/retroarch
rm -rf /opt/retroarch/retroarch.home