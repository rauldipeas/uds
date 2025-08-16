#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sSL https://api.github.com/repos/ilya-zlobintsev/LACT/releases | grep browser_download_url | grep download | grep 2404.deb | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
install_deb
gpu_info="$(lspci | grep -E "VGA|3D")"
if printf "%s" "$gpu_info" | grep -q NVIDIA >/dev/null; then
	sudo dpkg --add-architecture i386
	if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
		sudo add-apt-repository -y ppa:graphics-drivers/ppa
		sudo apt install -y --reinstall libvulkan1 libvulkan1:i386
	elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
		sudo apt update 2>/dev/null
		sudo apt install -y --reinstall libvulkan1 libvulkan1:i386
	fi
elif printf "%s" "$gpu_info" | grep -qE "AMD|Intel" >/dev/null; then
	sudo dpkg --add-architecture i386
	if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
		sudo add-apt-repository -y ppa:kisak/kisak-mesa
		sudo apt upgrade -y
		sudo apt install -y --reinstall libgl1-mesa-dri libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386
	elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
		sudo apt update 2>/dev/null
		sudo apt upgrade -y
		sudo apt install -y --reinstall libgl1-mesa-dri libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386
	fi
	cd /tmp
	rm -f /tmp/*.deb
	wget -q --show-progress "$(curl -sSL https://api.github.com/repos/Umio-Yasuno/amdgpu_top/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)"
	sudo apt install -y --reinstall "$PWD"/amdgpu-top*.deb
	sudo rm -f /usr/share/applications/amdgpu_top-tui.desktop
	printf 'amdgpu'|sudo tee /etc/initramfs-tools/modules
	if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ];then
		sudo sed -i 's/Icon=utilities-system-monitor/Icon=amd/g' /usr/share/applications/amdgpu_top.desktop
	else
		mkdir -p "$HOME"/.local/share/icons
		wget -q --show-progress -O "$HOME"/.local/share/icons/amd.png https://logodix.com/logo/23611.png
		sudo sed -i 's/Icon=utilities-system-monitor/Icon=amd/g' /usr/share/applications/amdgpu_top.desktop
	fi
fi