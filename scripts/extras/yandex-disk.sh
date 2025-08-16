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
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
add_ppa
fix_launcher
printf 'deb http://repo.yandex.ru/yandex-disk/deb/ stable main' | sudo tee /etc/apt/sources.list.d/yandex-disk.list >/dev/null
wget -qO- http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/yandex-disk.gpg
sudo apt update
install_deb
printf "\e[32mAutenticar agora?\e[0m\e[31m (s/N)\e[0m"
read -r resp
convert_icons() {
    for file in *.svg; do
        tmp="$(mktemp)".png
        convert -density 1200 -background none "$file" -trim +repage "$tmp"
        size="$(identify -format "%[fx:max(w,h)]" "$tmp")"
        convert "$tmp" -gravity center -background none -extent "${size}"x"${size}" "${file%.svg}".png
        rm "$tmp"
    done
}
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.config/yd-tools/icons/{dark,light}
    cp /usr/share/icons/Papirus/24x24/panel/yd-* "$HOME"/.config/yd-tools/icons/dark/
    cp /usr/share/icons/Papirus-Light/24x24/panel/yd-* "$HOME"/.config/yd-tools/icons/light/
    cd "$HOME"/.config/yd-tools/icons/dark/
    convert_icons
    cd "$HOME"/.config/yd-tools/icons/light/
    convert_icons
    cd
    rm "$HOME"/.config/yd-tools/icons/{dark,light}/*.svg
    sudo convert -density 1200 -background none -resize 128x128 /usr/share/icons/Papirus/128x128/apps/yd-128.svg /usr/share/yd-tools/icons/yd-128.png
    sudo convert -density 1200 -background none -resize 128x128 /usr/share/icons/Papirus/22x22/panel/yd-ind-pause.svg /usr/share/yd-tools/icons/yd-128_g.png
fi
if [[ $resp =~ ^[Ss]$ ]]; then
    yandex-disk token &&
        yandex-disk start
fi