#!/bin/bash
set -e
sudo apt install -y --reinstall extrepo
sudo extrepo enable librewolf
sudo apt update
sudo apt install -y --reinstall chrome-gnome-shell librewolf
xdg-mime default librewolf.desktop x-scheme-handler/http
xdg-mime default librewolf.desktop x-scheme-handler/https