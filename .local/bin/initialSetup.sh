#!/usr/bin/env bash
if ! [ -d ~/.config/foot ]; then
  mkdir -p ~/.config/foot
  mkdir -p ~/.config/fuzzel
  read -p "Enter Scale (#.#): " SCALE
  echo "monitor=,preferred,auto,${SCALE}" >> ~/.config/hypr/custom/custom.conf
  ~/.config/ags/scripts/color_generation/switchwall.sh
fi
