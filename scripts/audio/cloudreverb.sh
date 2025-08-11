#!/bin/bash
set -e
mkdir -p /tmp/cloudreverb
cd /tmp/cloudreverb
rm -f /tmp/cloudreverb/*.zip
wget -q --show-progress "$(curl -s https://api.github.com/repos/xunil-cloud/CloudReverb/releases | grep browser_download_url | grep download | grep Linux-x86_64 | head -n1 | cut -d '"' -f4)"
unzip -oqq '*.zip'
mkdir -p "$HOME"/.vst3
find "$PWD" -type d -name '*.vst3' -exec cp -r '{}' "$HOME"/.vst3/ \;