#!/bin/bash
set -e
# shellcheck disable=SC1090
source <(curl -s https://rauldipeas.com.br/uds/functions.sh)

## Agnoster
set_bashrc
rm -rf "$HOME"/.bashrc.d/themes/agnoster
git clone -q https://github.com/speedenator/agnoster-bash "$HOME"/.bashrc.d/themes/agnoster
sed -i 's/darkblue black/darkgreen black/g' "$HOME"/.bashrc.d/themes/agnoster/agnoster.bash
cat <<EOF |tee "$HOME"/.bashrc.d/agnoster.bash>/dev/null
export THEME="\$HOME"/.bashrc.d/themes/agnoster/agnoster.bash
if [[ -f \$THEME ]]; then
    source \$THEME
fi
EOF

## Bat
sudo apt install -y --reinstall bat #batcat

## Ble.sh
cd /tmp
rm -fr /tmp/ble.sh
git clone -q --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh
make -C ble.sh install PREFIX="$HOME"/.local
set_bashrc
tee "$HOME"/.bashrc.d/ble.sh >/dev/null <<EOF
#source "$HOME"/.local/share/blesh/ble.sh --noattach
#[[ ! \${BLE_VERSION-} ]] || ble-attach
source -- "$HOME"/.local/share/blesh/ble.sh
EOF
tee "$HOME"/.blerc >/dev/null <<EOF
# desabilita syntax highlighting
bleopt highlight_syntax=
# desabilita highlighting baseado em filenames
bleopt highlight_filename=
# desabilita highlighting baseado em tipos de variável
bleopt highlight_variable=
# desabilita ambiguous completion
bleopt complete_ambiguous=
# desabilita menu-complete com TAB
bleopt complete_menu_complete=
# desabilita menu filtering (ex.: sugerir arquivos)
bleopt complete_menu_filter=
# desabilita marcador de EOF (ex.: "[ble: EOF]")
bleopt prompt_eol_mark=''
# desabilita marcador de erro (ex.: "[ble: exit %d]")
bleopt exec_errexit_mark=
# desabilita marcador de exit (ex.: "[ble: exit]")
bleopt exec_exit_mark=
# desabilita outros marcadores (ex.: "[ble: ...]")
bleopt edit_marker=
bleopt edit_marker_error=
# deixa o auto-complete com uma cor mais sútil
ble-face auto_complete='fg=240,underline,italic'
EOF

## Dropbear
sudo apt install -y --reinstall dropbear openssh-sftp-server

## FD
sudo apt install -y --reinstall fd-find #fdfind

## FDupes
sudo apt install -y --reinstall fdupes

## fzf
sudo apt install -y --reinstall fzf #Ctrl+R
set_bashrc
tee "$HOME"/.bashrc.d/fzf-history.sh >/dev/null <<EOF
export HISTTIMEFORMAT='%F %T '
__fzf_history() {
  selected=\$(history|tac|awk '!seen[\$0]++'|sed -E "s/^([ ]*[0-9]+[ ]+)([0-9-]+ [0-9:]+)/\1\x1b[38;5;43m\2\x1b[0m /"|fzf --ansi --expect=tab,enter \
    --prompt='Histórico > ' \
    --header='TAB: inserir  |  ENTER: executar' \
    --preview="printf {} | sed 's/^[ ]*[0-9]*[ ]*[0-9-]* [0-9:]*[ ]*//'" \
    --preview-window=down:1 \
    --height=100% --border)

  key=\$(head -n1 <<< "\$selected")
  cmd=\$(tail -n1 <<< "\$selected" | sed 's/^[ ]*[0-9]*[ ]*[0-9-]* [0-9:]*[ ]*//')

  if [[ \$key == enter ]]; then
    eval "\$cmd"
  elif [[ \$key == tab ]]; then
    READLINE_LINE="\$cmd"
    READLINE_POINT=\${#READLINE_LINE}
  fi
}
bind -x '"\C-r": __fzf_history'
EOF

## Liquid Prompt
sudo apt install -y --reinstall fonts-powerline liquidprompt
cp /usr/share/liquidprompt/liquidpromptrc-dist "$HOME"/.config/liquidpromptrc
sed -i 's/debian.theme/powerline.theme/' "$HOME"/.config/liquidpromptrc
set_bashrc
tee "$HOME"/.bashrc.d/liquidprompt.sh >/dev/null <<EOF
printf \$- | grep -q i 2>/dev/null && . /usr/share/liquidprompt/liquidprompt
lp_theme powerline
EOF
gsettings set org.gnome.desktop.interface monospace-font-name "'Ubuntu Mono 11'"

## LSD
sudo apt install -y --reinstall lsd
pacstall -IP nerd-fonts:ttf-ubuntu-nerd nerd-fonts:ttf-ubuntu-mono-nerd

## Micro
sudo apt install -y --reinstall micro
mkdir -p "$HOME"/.config/micro
tee "$HOME"/.config/micro/settings.json >/dev/null <<EOF
{
    "eofnewline": false
}
EOF

## Path
set_bashrc
tee "$HOME"/.bashrc.d/path.sh >/dev/null <<EOF
npm config set prefix "\$HOME"/.npm-global
export PATH="\$HOME"/.npm-global/bin:"\$PATH"
export PATH="\$HOME"/.local/share/gem/ruby/3.2.0/bin:"\$PATH"
export PATH="\$HOME"/.local/share/gem/bundle/bin:"\$PATH"
export BUNDLE_PATH="\$HOME"/.local/share/gem/bundle
EOF