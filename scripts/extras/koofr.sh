#!/bin/bash
set -e
mkdir -p /tmp/koofr
cd /tmp/koofr
rm -f /tmp/koofr/*.gz
wget -q --show-progress -O koofr-linux.tar.gz https://app.koofr.net/dl/apps/linux64
tar -xf koofr-linux.tar.gz
cd /tmp/koofr/koofr
yes n|"$PWD"/installer.sh
ln -fs "$HOME"/.koofr-dist/icon.png "$HOME"/.local/share/icons/koofr.png
sed -i "s|Icon=$HOME/.koofr-dist/icon.png|Icon=koofr|g" "$HOME"/.local/share/applications/koofr.desktop