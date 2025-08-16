#!/bin/bash
set -e
# shellcheck disable=SC2034
TARGET="$(curl -sSL https://api.github.com/repos/NatronGitHub/Natron/releases | grep browser_download_url | grep download | grep no-installer.tar.xz | head -n1 | cut -d '"' -f4)"
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
enter_tmp
download
tar xf Natron*.tar.xz
rm Natron*.tar.xz
mv Natron* "$HOME"/.local/share/natron
mkdir -p "$HOME"/.local/share/{applications,icons}
cp "$HOME"/.local/share/natron/Resources/pixmaps/natronIcon256_linux.png "$HOME"/.local/share/icons/natron.png
tee "$HOME"/.local/share/applications/natron.desktop >/dev/null <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Name=Natron 2
MimeType=application/x-natron
Exec="$HOME"/.local/share/natron/Natron %U
GenericName=Compositing software
Comment=Node-graph based compositing software
Categories=Graphics;2DGraphics;RasterGraphics;
Icon=natron
StartupNotify=true
EOF