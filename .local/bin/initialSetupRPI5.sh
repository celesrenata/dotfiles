#!/usr/bin/env bash
if ! [ -f ~/.local/share/initialSetup ]; then
  mkdir -p ~/.local/share
  mkdir -p ~/.config/foot
  mkdir -p ~/.config/fuzzel
  echo "monitor=,1920x1080@60,auto,1" > ~/.config/hypr/custom/custom.conf
  ~/.config/ags/scripts/color_generation/switchwall.sh
  if [ $? -eq 0 ]; then
    touch ~/.local/share/initialSetup
  fi
fi
