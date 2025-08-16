#!/bin/bash
set -e
printf 2|am -i --icons obs-studio
if [ "$(gsettings get org.gnome.desktop.interface icon-theme)" == "'Papirus-Dark'" ]; then
    mkdir -p "$HOME"/.icons/Papirus-Dark/64x64/apps
    ln -fs /usr/share/icons/Papirus-Dark/64x64/apps/obs.svg "$HOME"/.icons/Papirus-Dark/64x64/apps/obs-studio.svg
fi