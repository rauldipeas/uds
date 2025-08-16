#!/bin/bash
set -e
# shellcheck disable=SC2034
INSTNAME='gedit-plugins'
# shellcheck disable=SC1090
source <(curl -sL https://rauldipeas.com.br/uds/functions.sh)
install_deb
#gedit gedit-common gedit-plugin-bookmarks gedit-plugin-bracket-completion gedit-plugin-character-map gedit-plugin-code-comment gedit-plugin-color-picker gedit-plugin-draw-spaces gedit-plugin-git gedit-plugin-join-lines gedit-plugin-multi-edit gedit-plugin-session-saver gedit-plugin-smart-spaces gedit-plugin-terminal gedit-plugin-text-size gedit-plugin-word-completion gedit-plugins gedit-plugins-common gir1.2-amtk-5 gir1.2-ggit-1.0 gir1.2-gtksource-300 gir1.2-gucharmap-2.90 gir1.2-tepl-6 libgedit-amtk-5-0 libgedit-amtk-5-common libgedit-gtksourceview-300-0 libgedit-gtksourceview-300-common libgit2-glib-1.0-0 libgucharmap-2-90-7 libtepl-6-4 libtepl-common
dconf reset -f /org/gnome/gedit
gsettings set org.gnome.gedit.plugins active-plugins "[\
    'terminal',\
    'git',\
    'spell',\
    'sort',\
    'modelines',\
    'filebrowser',\
    'docinfo'\
]"
gsettings set org.gnome.gedit.preferences.editor editor-font "'Ubuntu Sans Mono 11'"
gsettings set org.gnome.gedit.preferences.editor use-default-font false
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
    gsettings set org.gnome.gedit.preferences.editor scheme "'Yaru-dark'"
elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
    gsettings set org.gnome.gedit.preferences.editor scheme "'Oblivion'"
fi
gsettings set org.gnome.gedit.preferences.editor wrap-mode "'none'"
gsettings set org.gnome.gedit.preferences.ui side-panel-visible true