#!/usr/bin/env bash
if ! [ -d ~/.config/foot ]; then
  mkdir -p ~/.config/foot
  mkdir -p ~/.config/fuzzel
  ~/.config/ags/scripts/color_generation/switchwall.sh
fi
