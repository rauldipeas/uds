#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME='flowblade'
# shellcheck disable=SC2034
LN='io.github.jliljebl.Flowblade'
# shellcheck disable=SC2034
SWMC='Flowblade'
# shellcheck disable=SC2034
EXEC_OLD='flowblade'
# shellcheck disable=SC2034
EXEC_NEW='env GDK_BACKEND=x11 flowblade'
# shellcheck disable=SC2034
INSTNAME='flowblade'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
fix_launcher
install_deb