#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME='thunderbird'
# shellcheck disable=SC2034
LN='thunderbird'
# shellcheck disable=SC2034
EXEC_OLD='/usr/lib/thunderbird/thunderbird'
# shellcheck disable=SC2034
EXEC_NEW='env GDK_BACKEND=x11 thunderbird'
# shellcheck disable=SC2034
ICON_OLD='/usr/lib/thunderbird/chrome/icons/default/default128.png'
# shellcheck disable=SC2034
ICON_NEW='thunderbird'
# shellcheck disable=SC2034
DEPS="g++\
    git\
    libqt5x11extras5-dev\
    make\
    qdbus-qt5\
    qt5-qmake\
    qtbase5-dev\
    zip"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
fix_launcher
install_deb
pacstall -IP thunderbird-bin
cd /tmp
rm -rf /tmp/systray-x
git clone https://github.com/Ximi1970/systray-x
cd /tmp/systray-x
make clean
make OPTIONS="DEFINES+=NO_KDE_INTEGRATION"
mkdir -p "$HOME"/.mozilla/native-messaging-hosts
cp -f "$PWD"/app/config/linux/SysTray_X.json "$HOME"/.mozilla/native-messaging-hosts/
TB_PROFILE="$(find "$HOME"/.thunderbird/ -type d -name '*default-release')"
mkdir -p "$TB_PROFILE"/extensions/
cp -f "$PWD"/systray-x@Ximi1970.xpi "$TB_PROFILE"/extensions/