#!/bin/bash
set -e
enter_tmp() {
    sudo find /tmp -mindepth 1 -maxdepth 1 -writable -not -path "/tmp/.veracrypt*" -not -path "*-unix*" -exec rm -fr {} +
    cd /tmp
}

download() {
    wget -q --show-progress "$TARGET"
}

fix_launcher() {
    # shellcheck disable=SC2153
    sudo rm -f /usr/local/share/custom-launchers/"$BASENAME"
    sudo tee /usr/local/share/custom-launchers/"$BASENAME" >/dev/null <<EOF
if [ -f /usr/share/applications/$LN.desktop ] || [ -f /usr/local/share/applications/$LN.desktop ];then
    if [ -f  /usr/share/applications/$LN.desktop ];then
        sed -i 's|^Exec=$EXEC_OLD|Exec=$EXEC_NEW|g' /usr/share/applications/$LN.desktop
        sed -i 's|Icon=$ICON_OLD|Icon=$ICON_NEW|g' /usr/share/applications/$LN.desktop
        else
        if [ -f  /usr/local/share/applications/$LN.desktop ];then
            sed -i 's|^Exec=$EXEC_OLD|Exec=$EXEC_NEW|g' /usr/local/share/applications/$LN.desktop
            sed -i 's|Icon=$ICON_OLD|Icon=$ICON_NEW|g' /usr/local/share/applications/$LN.desktop    
        fi
    fi
fi
if [ -f /usr/share/applications/$LN.desktop ] || [ -f /usr/local/share/applications/$LN.desktop ];then
    if [ -f  /usr/share/applications/$LN.desktop ];then
        if ! grep 'StartupWMClass=$SWMC' /usr/share/applications/$LN.desktop>/dev/null;then
            printf '\nStartupWMClass=$SWMC'|tee -a /usr/share/applications/$LN.desktop>/dev/null
        fi
        else
        if [ -f  /usr/local/share/applications/$LN.desktop ];then
            if ! grep 'StartupWMClass=$SWMC' /usr/local/share/applications/$LN.desktop>/dev/null;then
                printf '\nStartupWMClass=$SWMC'|tee -a /usr/local/share/applications/$LN.desktop>/dev/null
            fi
        fi
    fi
fi
EOF
    if [ -n "$BASENAME2" ]; then
        sudo tee /usr/local/share/custom-launchers/"$BASENAME2" >/dev/null <<EOF
if [ -f /usr/share/applications/$LN2.desktop ];then
    sed -i 's|^Exec=$EXEC_OLD2|Exec=$EXEC_NEW2|g' /usr/share/applications/$LN2.desktop
    sed -i 's|Icon=$ICON_OLD2|Icon=$ICON_NEW2|g' /usr/share/applications/$LN2.desktop
    if ! grep 'StartupWMClass=$SWMC2' /usr/share/applications/$LN2.desktop>/dev/null;then
        printf '\nStartupWMClass=$SWMC2'|tee -a /usr/share/applications/$LN2.desktop>/dev/null
    fi
fi
EOF
    fi
}

add_ppa() {
    if [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == ubuntu ]; then
        sudo add-apt-repository -y ppa:"$PPA"
    elif [ "$(grep '^ID=' /etc/os-release | cut -d '=' -f2)" == debian ]; then
        PPA_NAME="$(printf "%s" "$PPA" | sed 's|/|-|g')"
        PPA_ADDRESS="https://launchpad.net/~$(printf "%s" "$PPA" | cut -d '/' -f1)/+archive/ubuntu/$(printf "%s" "$PPA" | cut -d '/' -f2)"
        PPA_KEY="$(wget -qO- "$PPA_ADDRESS" | grep fingerprint | head -n1 | cut -d '=' -f5 | cut -d '"' -f1)"
        sudo wget -qO /etc/apt/trusted.gpg.d/"$PPA_NAME".gpg "https://keyserver.ubuntu.com/pks/lookup?op=get&search=$PPA_KEY"
        #echo "deb http://ppa.launchpadcontent.net/$PPA/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/"$PPA_NAME".list
        sudo tee /etc/apt/sources.list.d/"$PPA_NAME".sources >/dev/null <<EOF
Types: deb
URIs: https://ppa.launchpadcontent.net/$PPA/ubuntu/
Suites: noble
Components: main
Signed-By: /etc/apt/trusted.gpg.d/$PPA_NAME.gpg
EOF
        sudo apt update
    fi
}

install_deb() {
    if [ -n "$DEPS" ]; then
        printf "%s" "$DEPS" | xargs sudo apt install -y --reinstall
    fi
    if [ -n "$INSTNAME" ]; then
        printf "%s" "$INSTNAME" | xargs sudo apt install -y --reinstall
    else
        sudo apt install -y --reinstall "$(sudo find /tmp -mindepth 1 -maxdepth 1 -writable -not -path "/tmp/.veracrypt*" -not -path "*-unix*" -name '*.deb')"
    fi
}

gei() {
    ID="$1"
    SHELL_VER="$(gnome-shell --version | awk '{print $3}')"
    EXT_INFO="$(curl -sL "https://extensions.gnome.org/extension-info/?pk=$ID&shell_version=$SHELL_VER")"
    UUID="$(printf "%s" "$EXT_INFO" | jq -r .uuid)"
    DOWNLOAD_URL="$(printf "%s" "$EXT_INFO" | jq -r .download_url)"

    if [ -z "$UUID" ] || [ "$DOWNLOAD_URL" = "null" ]; then
        printf "%s" "Falha ao obter UUID ou URL. Verifique se a extensão suporta GNOME $SHELL_VER".
        return 1
    fi

    FULL_URL="https://extensions.gnome.org$DOWNLOAD_URL"
    TMPFILE=$(mktemp)
    if ! wget -q --show-progress -O "$TMPFILE" "$FULL_URL"; then
        printf "Falha no download."
        rm -f "$TMPFILE"
        return 1
    fi

    gnome-extensions install -f "$TMPFILE" && printf "%s" "Extensão instalada: $UUID"
    rm -f "$TMPFILE"
}

set_bashrc() {
    mkdir -p "$HOME"/.bashrc.d
    cp /etc/skel/.bashrc "$HOME"/.bashrc.d/default-bashrc.sh
    tee "$HOME"/.bashrc >/dev/null <<EOF
if [ -d "\$HOME/.bashrc.d" ]; then
  for f in "\$HOME"/.bashrc.d/*.sh; do
    [ "\$f" = "\$HOME"/.bashrc.d/liquidprompt.sh ] && continue
    [ -r "\$f" ] && . "\$f"
  done
fi
EOF
}
