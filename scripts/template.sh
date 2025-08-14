#!/bin/bash
set -e
BASENAME=''
LN=''
SWMC=''
TARGET="$()"
EXEC_OLD=''
EXEC_NEW=''
ICON_OLD=''
ICON_NEW=''
DEPS=""
PPA=''
INSTNAME=''
BASENAME2=''
LN2=''
SWMC2=''
EXEC_OLD2=''
EXEC_NEW2=''
ICON_OLD2=''
ICON_NEW2=''
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
add_ppa
fix_launcher
install_deb