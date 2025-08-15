#!/bin/bash
set -e
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)

## Bibata mouse cursor
mkdir -p /tmp/bibata
cd /tmp/bibata
rm -f /tmp/bibata/*.xz
wget -q --show-progress "$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases | grep browser_download_url | grep download | grep Modern-Ice.tar.xz | head -n1 | cut -d '"' -f4)"
tar -xf Bibata*.tar.xz
rm Bibata*.tar.xz
sudo cp -r Bibata* /usr/share/icons/
sudo update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Bibata-Modern-Ice/cursor.theme 100
sudo update-alternatives --set x-cursor-theme /usr/share/icons/Bibata-Modern-Ice/cursor.theme
gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Ice

## GNOME shell
sudo apt install -y --reinstall\
  gnome-shell-extension-alphabetical-grid\
  gnome-shell-extension-gsconnect
  #gnome-shell-extension-prefs

mkdir -p "$HOME"/.local/share/applications
tee "$HOME"/.local/share/applications/gnome-extensions-web.desktop >/dev/null <<EOF
[Desktop Entry]
Type=Application
Name=Extensions
Name[pt_BR]=Extensões
Exec=xdg-open https://extensions.gnome.org/local
Icon=org.gnome.Extensions
Terminal=false
StartupNotify=true
EOF

dconf reset -f /org/gnome/shell/extensions/appindicator/
dconf reset -f /org/gnome/shell/extensions/dash-to-dock/
dconf reset -f /org/gnome/shell/extensions/ding/
dconf reset -f /org/gnome/shell/extensions/tiling-assistant/

#gsettings set org.gnome.shell.extensions.dash-to-dock click-action minimize
#gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
#gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
#gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
#gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
#gsettings set org.gnome.shell.extensions.dash-to-dock show-icons-notifications-counter false

#gsettings set org.gnome.shell.extensions.ding keep-arranged true
#gsettings set org.gnome.shell.extensions.ding show-home false
#gsettings set org.gnome.shell.extensions.ding start-corner top-right

dconf write /org/gnome/shell/extensions/alphabetical-app-grid/sort-folder-contents false

dconf write /org/gnome/shell/extensions/app-hider/hidden-apps "[\
    'diodon.desktop',\
    'display-im6.q16.desktop',\
    'micro.desktop',\
    'mpv.desktop',\
    'syncthing-start.desktop',\
    'syncthing-ui.desktop',\
    'winetricks.desktop'\
]"

if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
  dconf write /org/gnome/shell/extensions/appindicator/custom-icons "[\
    ('2wydifuftb', 'gtk-dialog-authentication-panel', ''),\
    ('Cable', 'ladi-starting', ''),\
    ('Diodon', 'notes-panel', ''),\
    ('Proton Mail Bridge', 'protonmail-indicator', ''),\
    ('q4wine', 'folder-white-wine', ''),\
    ('QjackCtl', 'gnome-device-manager', ''),\
    ('systray', 'cloudstatus', ''),\
    ('un-reboot', 'system-reboot-symbolic', ''),\
    ('veracrypt', 'veracrypt-panel', ''),\
  ]"
else
  dconf write /org/gnome/shell/extensions/appindicator/custom-icons "[\
    ('Cable', 'audio-card-symbolic', ''),\
    ('Diodon', 'edit-paste-symbolic', ''),\
    ('KeePassXC', 'passwords-app-symbolic', ''),\
    ('Proton Mail Bridge', 'padlock-open-symbolic', ''),\
    ('QjackCtl', 'audio-speakers', ''),\
    ('veracrypt', 'safety-symbolic', '')\
  ]"
fi

dconf reset -f /org/gnome/shell/extensions/azwallpaper/
dconf write /org/gnome/shell/extensions/azwallpaper/bing-download-directory "'/home/rauldipeas/Imagens/Bing Wallpapers'"
dconf write /org/gnome/shell/extensions/azwallpaper/bing-wallpaper-download true
dconf write /org/gnome/shell/extensions/azwallpaper/bing-wallpaper-market "'pt-BR'"
dconf write /org/gnome/shell/extensions/azwallpaper/bing-wallpaper-resolution "'1920x1080'"
dconf write /org/gnome/shell/extensions/azwallpaper/slideshow-directory "'/home/rauldipeas/Sync/Imagens/Papéis de parede'"
dconf write /org/gnome/shell/extensions/azwallpaper/slideshow-slide-duration "(0, 5, 0)"

#dconf reset -f /org/gnome/shell/extensions/blur-my-shell/
#dconf load /org/gnome/shell/extensions/dash-to-panel/ <(wget -qO- https://rauldipeas.com.br/uds/settings/desktop/gnome/blur-my-shell.conf)

dconf reset -f /org/gnome/shell/extensions/dash-to-panel/
dconf load /org/gnome/shell/extensions/dash-to-panel/ <(wget -qO- https://rauldipeas.com.br/uds/settings/desktop/gnome/dash-to-panel.conf)

dconf reset -f /org/gnome/shell/extensions/editdesktopfiles/
dconf write /org/gnome/shell/extensions/editdesktopfiles/custom-edit-command "'x-terminal-emulator -e micro %U'"
dconf write /org/gnome/shell/extensions/editdesktopfiles/use-custom-edit-command true

#dconf reset -f /org/gnome/shell/extensions/Logo-menu/
#dconf write /org/gnome/shell/extensions/Logo-menu/menu-button-icon-image 5
#dconf write /org/gnome/shell/extensions/Logo-menu/menu-button-icon-size 22
#dconf write /org/gnome/shell/extensions/Logo-menu/menu-button-terminal "'x-terminal-emulator'"
#dconf write /org/gnome/shell/extensions/Logo-menu/show-activities-button true
#dconf write /org/gnome/shell/extensions/Logo-menu/show-lockscreen true
#dconf write /org/gnome/shell/extensions/Logo-menu/show-power-options true
#dconf write /org/gnome/shell/extensions/Logo-menu/symbolic-icon true

dconf reset -f /org/gnome/shell/extensions/notification-configurator/
dconf write /org/gnome/shell/extensions/notification-configurator/notification-position "'right'"

dconf reset -f /org/gnome/shell/extensions/rounded-window-corners-reborn/
dconf write /org/gnome/shell/extensions/rounded-window-corners-reborn/blacklist "['gnome-terminal-server']"
dconf write /org/gnome/shell/extensions/rounded-window-corners-reborn/global-rounded-corner-settings "{\
    'padding': <{\
        'left': uint32 1,\
        'right': 1,\
        'top': 1,\
        'bottom': 1\
    }>,\
    'keepRoundedCorners': <{\
        'maximized': false,\
        'fullscreen': false\
    }>,\
    'borderRadius': <uint32 7>,\
    'smoothing': <0.0>,\
    'borderColor': <(0.5, 0.5, 0.5, 1.0)>,\
    'enabled': <true>\
}"

#dconf write /org/gnome/shell/extensions/status-area-horizontal-spacing/hpadding 3

dconf write /org/gnome/shell/extensions/syncthing-toggle/port 8080
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
  dconf write /org/gnome/shell/extensions/syncthing-toggle/icon-name "'si-syncthing-idle'"
fi

#dconf reset -f /org/gnome/shell/extensions/window-title-is-back/
#dconf write /org/gnome/shell/extensions/window-title-is-back/colored-icon true

dconf reset -f /org/gnome/shell/extensions/window-centering/
dconf write /org/gnome/shell/extensions/window-centering/allow-forced-resize true
dconf write /org/gnome/shell/extensions/window-centering/centering-keybinding "['<Super><Shift>C']"
dconf write /org/gnome/shell/extensions/window-centering/frame-height 88
dconf write /org/gnome/shell/extensions/window-centering/frame-width 94

gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter check-alive-timeout 20000
gsettings set org.gnome.nautilus.icon-view default-zoom-level small-plus
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 'uint32 3700'
gsettings set org.gnome.shell favorite-apps "[\
    'org.gnome.Nautilus.desktop',\
    'librewolf.desktop',\
    'thunderbird.desktop',\
    'spike-desktop.desktop',\
    'reaper-AM.desktop',\
    'com.blackmagicdesign.resolve.desktop',\
    'gimp.desktop',\
    'freetube.desktop'\
]"

dconf reset -f /org/gnome/terminal/
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ audible-bell false
#gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-color '#00360e' #blur
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-color '#00210e'
#gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-transparency-percent 30 #blur
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-transparency-percent 8
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ foreground-color '#ffffff'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ use-theme-transparency false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ use-transparent-background true

#dconf reset -f /org/gnome/TextEditor/
#gsettings set org.gnome.TextEditor highlight-current-line true
#gsettings set org.gnome.TextEditor show-line-numbers true
#gsettings set org.gnome.TextEditor show-map true
#gsettings set org.gnome.TextEditor spellcheck false
#gsettings set org.gnome.TextEditor wrap-text false

gei 5895 # app-hider
#gei 3193 # blur-my-shell
gei 1160 # dash-to-panel
gei 7397 # edit-desktop-files
gei 5410 # grand-theft-focus
#gei 1319 # gsconnect
#gei 4451 # logo-menu
gei 8249 # notification-configurator
gei 7048 # rounded-window-corners-reborn
#gei 355  # status-area-horizontal-spacing
gei 7180 # syncthing-toggle
#gei 3960 # transparent-top-bar-adjustable-transparency
#gei 19   # user-themes
gei 6281 # wallpaper-slideshow
gei 8087 # window-centering
gei 6343 # window-gestures
#gei 6310 # window-title-is-back

gnome-extensions disable ding@rastersoft.com
gnome-extensions disable ubuntu-dock@ubuntu.com
gnome-extensions enable AlphabeticalAppGrid@stuarthayhurst
gnome-extensions enable app-hider@lynith.dev
gnome-extensions enable azwallpaper@azwallpaper.gitlab.com
gnome-extensions enable dash-to-panel@jderose9.github.com
gnome-extensions enable editdesktopfiles@dannflower
gnome-extensions enable grand-theft-focus@zalckos.github.com
gnome-extensions enable gsconnect@andyholmes.github.io
gnome-extensions enable notification-configurator@exposedcat
gnome-extensions enable rounded-window-corners@fxgn
gnome-extensions enable syncthing-toggle@rehhouari.github.com
gnome-extensions enable tiling-assistant@ubuntu.com
gnome-extensions enable ubuntu-appindicators@ubuntu.com
gnome-extensions enable window-centering@hnjjhmtr27
gnome-extensions enable windowgestures@extension.amarullz.com

#tee "$HOME"/.local/bin/enable-extensions >/dev/null <<EOF
##!/bin/bash
#for ext in \$(gnome-extensions list); do
#  gnome-extensions enable "\$ext"
#done
#rm "\$HOME"/.config/autostart/enable-extensions.desktop "\$HOME"/.local/bin/enable-extensions
#EOF
#tee "$HOME"/.config/autostart/enable-extensions.desktop >/dev/null <<EOF
#[Desktop Entry]
#Type=Application
#Name=Ativar extensões do GNOME
#Exec=bash $HOME/.local/bin/enable-extensions
#Icon=org.gnome.Shell.Extensions
#Terminal=false
#Categories=System;Utility;
#StartupNotify=true
#EOF

## Papirus icon theme
sudo add-apt-repository -y ppa:papirus/papirus
sudo apt install -y --reinstall papirus-icon-theme
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
#papirus-folders -C paleorange
if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
  papirus-folders -C yaru
elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
  papirus-folders -C adwaita
fi