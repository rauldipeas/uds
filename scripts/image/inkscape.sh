#!/bin/bash
set -e
# shellcheck disable=SC2034
BASENAME='inkscape'
# shellcheck disable=SC2034
LN='org.inkscape.Inkscape'
# shellcheck disable=SC2034
EXEC_OLD='inkscape '
# shellcheck disable=SC2034
EXEC_NEW='inkscape_theme-fix '
# shellcheck disable=SC2034
INSTNAME='inkscape'
# shellcheck disable=SC1090
source <(curl -sSL https://rauldipeas.com.br/uds/functions.sh)
fix_launcher
install_deb
sudo tee /usr/local/bin/inkscape_theme-fix >/dev/null <<EOF
#!/bin/bash
set -e
env GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme) inkscape $@
EOF
sudo chmod +x /usr/local/bin/inkscape_theme-fix