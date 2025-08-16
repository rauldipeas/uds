#!/bin/bash
set -e
# shellcheck disable=SC2034
DEPS="nohang\
	qjackctl\
	ubuntustudio-lowlatency-settings\
	ubuntustudio-performance-tweaks\
	ubuntustudio-pipewire-config"
# shellcheck disable=SC2034
PPA='savoury1/multimedia'
# shellcheck disable=SC2034
INSTNAME='helvum'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
add_ppa
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
	sudo apt install -y --reinstall ubuntu-archive-keyring
    sudo tee /etc/apt/sources.list.d/ubuntu.sources >/dev/null <<EOF
Types: deb
URIs: http://archive.ubuntu.com/ubuntu/
Suites: noble-updates
Components: universe
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF
	sudo tee /etc/apt/preferences.d/ubuntu >/dev/null <<EOF
Package: *
Pin: release o=Ubuntu
Pin-Priority: 1
EOF
	sudo tee /etc/apt/preferences.d/savoury1-multimedia >/dev/null <<EOF
Package: *
Pin: release o=LP-PPA-savoury1-multimedia
Pin-Priority: 1

Package: *spa*
Pin: release o=LP-PPA-savoury1-multimedia
Pin-Priority: 1000

Package: *pipewire*
Pin: release o=LP-PPA-savoury1-multimedia
Pin-Priority: 1000

Package: *wireplumber*
Pin: release o=LP-PPA-savoury1-multimedia
Pin-Priority: 1000
EOF
fi
sudo debconf-set-selections <<<'jackd2 jackd/tweak_rt_limits string true'
install_deb
sudo apt autoremove --purge -y qmidinet qpwgraph
sudo usermod -aG audio,pipewire "$USER"
sudo wget -q --show-progress -O /etc/udev/rules.d/99-cpu-dma-latency.rules https://github.com/Ardour/ardour/raw/refs/heads/master/tools/udev/99-cpu-dma-latency.rules >/dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger
sudo sed -i 's/ nosmt=force//g' /etc/default/grub.d/ubuntustudio.cfg
sudo sed -i 's/threadirqs/threadirqs nosmt=force/g' /etc/default/grub.d/ubuntustudio.cfg
sudo update-grub
mkdir -p "$HOME"/.config/rncbc.org
wget -q --show-progress -O "$HOME"/.config/rncbc.org/QjackCtl.conf https://rauldipeas.com.br/uds/settings/audio/jack/QjackCtl.conf
mkdir -p "$HOME"/.config/pipewire/pipewire.conf.d
export QOPT=128
export ROPT=44100
curl -sSL https://rauldipeas.com.br/uds/settings/audio/pipewire/99-custom.conf | envsubst | tee "$HOME"/.config/pipewire/pipewire.conf.d/99-custom.conf >/dev/null
systemctl --user restart pipewire pipewire-pulse
sudo mkdir -p /usr/local/{bin,share/applications}
sudo wget -q --show-progress -O /usr/local/bin/pipewire-latency-switcher https://rauldipeas.com.br/uds/settings/audio/pipewire/pipewire-latency-switcher
sudo chmod +x /usr/local/bin/pipewire-latency-switcher
sudo wget -q --show-progress -O /usr/local/share/applications/pipewire-latency-switcher.desktop https://rauldipeas.com.br/uds/settings/audio/pipewire/pipewire-latency-switcher.desktop
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
	sudo sed -i 's/audio-speakers/hifi' /usr/local/share/applications/pipewire-latency-switcher.desktop
fi
sudo wget -q --show-progress -O /usr/local/bin/toggle-pipewire-jack https://rauldipeas.com.br/uds/settings/audio/pipewire/toggle-pipewire-jack
sudo chmod +x /usr/local/bin/toggle-pipewire-jack
mkdir -p "$HOME"/.config/nohang
tee "$HOME"/.config/nohang/nohang.conf >/dev/null <<EOF
notify_every = 300
min_notify_mem = 200
memory_limit_mb=8000
memory_limit_percent=80
EOF