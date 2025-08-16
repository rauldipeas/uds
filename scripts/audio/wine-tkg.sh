#!/bin/bash
set -e
WINEVERSION='9.0'
TkG="https://github.com/Kron4ek/Wine-Builds/releases/download/$WINEVERSION/wine-$WINEVERSION-staging-tkg-amd64.tar.xz"
cd /tmp
rm -fr /tmp/wine*tkg*
wget -q --show-progress "$TkG"
tar -xf wine*tkg*.tar.xz
rm -fr wine*tkg*.tar.xz "$HOME"/.local/share/wine-tkg
mv wine*tkg* "$HOME"/.local/share/wine-tkg
sudo tee /etc/profile.d/wine-tkg.sh >/dev/null <<EOF
if [ -d "\$HOME"/.local/share/wine-tkg ] ; then
    	PATH="\$HOME/.local/share/wine-tkg/bin:\$PATH"
    	export WINEFSYNC=1
fi
EOF
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
	if grep contrib /etc/apt/sources.list >/dev/null; then
		printf 'contrib ativado'
	else
		sudo sed -i 's/main/main contrib/g' /etc/apt/sources.list
		sudo apt update
	fi
fi
printf "%s" "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections
sudo apt install -y --reinstall cabextract ttf-mscorefonts-installer winbind winetricks
if [ -d "$HOME"/.wine ]; then
	rm -f "$HOME"/.wine/dosdevices/*
	ln -fs "$HOME"/.wine/drive_c "$HOME"/.wine/dosdevices/c:
	ln -fs / "$HOME"/.wine/dosdevices/z:
fi
winetricks -f -q dxvk
#winetricks -f -q mfc42 # (instaladores de plugins jack-sparrow)
#winetricks dwrite=disabled # (caractéres estranhos tipo árabe)
rm -fr "$HOME"/.config/menus/applications-merged/wine* "$HOME"/.local/share/applications/wine* "$HOME"/.local/share/desktop-directories/wine*
find "$HOME"/.wine/drive_c/ -name "*.lnk" -exec wine "$(find /usr/lib* -name winemenubuilder.exe | grep x86_64)" '{}' \;
mkdir -p "$HOME"/.local/share/applications/wine/Programs
find "$HOME"/.local/share/applications/wine/Programs/ -name "*.desktop" -exec sed -i 's/wine-stable/wine/g' '{}' \;
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*agreement*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*changelog*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*chart*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*desinstala*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*eula*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*guide*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*hist*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*manual*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*un-install*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*uninstall*' -exec rm -frv {} +
find "$HOME"/.config/menus "$HOME"/.local/share/applications/wine "$HOME"/.local/share/desktop-directories -type f -iname '*what*' -exec rm -frv {} +
find "$HOME"/.local/share/icons/hicolor/ -type f -iname "*.png" -exec identify {} \; 2>&1 | grep -i error | cut -d '@' -f1 | sed 's/.*header //g' | sed 's/`//g' | sed 's/\ /\\ /g' | sed "s/'\\\//g" | xargs rm -frv
find "$HOME"/.local/share/icons/hicolor/ -type f -iname "*.svg" -exec identify {} \; 2>&1 | grep -i error | cut -d '@' -f1 | sed 's/.*header //g' | sed 's/`//g' | sed 's/\ /\\ /g' | sed "s/'\\\//g" | xargs rm -frv
find "$HOME"/.local/share/applications/wine -type d -empty -delete