#!/bin/bash
set -e
wget -qO- https://ulaa.zoho.com/release/linux/stable/pubkey | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/ulaa-browser-release.gpg
printf 'deb https://ulaa.zoho.com/release/linux/stable /' | sudo tee /etc/apt/sources.list.d/ulaa-browser-release.list >/dev/null
sudo apt update
sudo apt install --reinstall ulaa-browser