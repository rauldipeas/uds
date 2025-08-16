#!/bin/bash
set -e
# shellcheck disable=SC2034
#PPA='unit193/encryption'
# shellcheck disable=SC2034
#INSTNAME='veracrypt'
# shellcheck disable=SC1090
#source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
#add_ppa
#install_deb
pacstall -IP veracrypt-deb
mkdir -p "$HOME"/{.config/autostart,.local/bin}
tee "$HOME"/.config/autostart/veracrypt.desktop >/dev/null <<EOF
[Desktop Entry]
Type=Application
Exec=veracrypt-mount
Icon=veracrypt
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Montar VeraCrypt
EOF
tee "$HOME"/.local/bin/veracrypt-mount >/dev/null <<EOF
#!/bin/bash
set -e
#veracrypt /caminho/volume.crypt /media/veracrypt1
EOF
chmod +x "$HOME"/.local/bin/veracrypt-mount