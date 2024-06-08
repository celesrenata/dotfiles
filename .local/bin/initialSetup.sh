#!/usr/bin/env bash
imgpath=~/Backgrounds/love-is-love.jpg
cursorposx=$(hyprctl cursorpos -j | gojq '.x' 2>/dev/null) || cursorposx=960
cursorposy=$(hyprctl cursorpos -j | gojq '.y' 2>/dev/null) || cursorposy=540
cursorposy_inverted=$(( screensizey - cursorposy ))
if ! [ -f ~/.local/share/initialSetup ]; then
  rsync -azL --no-perms .configstaging/ .config 2> /dev/null
  mkdir -p ~/.local/share
  mkdir -p ~/.config/foot
  mkdir -p ~/.config/fuzzel
  mkdir -p ~/Videos
  echo "monitor=,preferred,auto,1" > ~/.config/hypr/custom/custom.conf
  swww img "$imgpath" --transition-step 100 --transition-fps 60 \
	  --transition-type grow --transition-angle 30 --transition-duration 2 \
	  --transition-pos "$cursorposx, $cursorposy_inverted"
  ~/.config/ags/scripts/color_generation/colorgen.sh "${imgpath}" --apply --smart
  if [ $? -eq 0 ]; then
    touch ~/.local/share/initialSetup
    reboot
  fi
fi
