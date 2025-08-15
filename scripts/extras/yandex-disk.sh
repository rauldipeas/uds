#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME=yandex-disk
# shellcheck disable=SC2034
LN='Yandex.Disk-indicator'
# shellcheck disable=SC2034
SWMC='indicator.py'
# shellcheck disable=SC2034
ICON_OLD='/usr/share/yd-tools/icons/yd-128.png'
# shellcheck disable=SC2034
ICON_NEW='yandex-disk'
# shellcheck disable=SC2034
PPA='slytomcat/ppa'
# shellcheck disable=SC2034
DEPS='yd-tools'
# shellcheck disable=SC2034
INSTNAME='yandex-disk'
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)
add_ppa
fix_launcher
printf 'deb http://repo.yandex.ru/yandex-disk/deb/ stable main' | sudo tee /etc/apt/sources.list.d/yandex-disk.list >/dev/null
wget -qO- http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/yandex-disk.gpg
sudo apt update
install_deb
printf "\e[32mAutenticar agora?\e[0m\e[31m (s/N)\e[0m"
read -r resp
if [[ $resp =~ ^[Ss]$ ]]; then
    yandex-disk token &&
        yandex-disk start
fi