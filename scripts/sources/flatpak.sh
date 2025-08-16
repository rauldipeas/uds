#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='gnome-software-plugin-flatpak'
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
install_deb
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo