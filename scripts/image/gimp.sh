#!/bin/bash
set -e
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
	# shellcheck disable=SC2034
	DEPS="libcanberra-gtk-module\
		gtk2-engines-murrine\
		gtk2-engines-pixbuf"
elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
	# shellcheck disable=SC2034
	DEPS="libcanberra-gtk3-module\
		gtk2-engines-murrine\
		gtk2-engines-pixbuf"
fi
# shellcheck disable=SC2034
PPA='ubuntuhandbook1/gimp-3'
# shellcheck disable=SC2034
INSTNAME='gimp'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
add_ppa
install_deb
mkdir -p "$HOME"/.config/GIMP/3.0
wget -q --show-progress -O "$HOME"/.config/GIMP/3.0/gimprc https://rauldipeas.com.br/uds/settings/image/gimp/gimprc
wget -q --show-progress -O "$HOME"/.config/GIMP/3.0/sessionrc https://rauldipeas.com.br/uds/settings/image/gimp/sessionrc