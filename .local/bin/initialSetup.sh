#!/usr/bin/env bash
imgpath=~/Backgrounds/love-is-love.jpg

if ! [ -f ~/.local/share/initialSetup ]; then
  rsync -azL --no-perms ~/.configstaging/ ~/.config 2> /dev/null
  mkdir -p ~/.local/share
  mkdir -p ~/.config/foot
  mkdir -p ~/.config/fuzzel
  mkdir -p ~/Videos
  
  # Preserve existing custom.conf or create default
  if [ ! -f ~/.config/hypr/custom.conf ]; then
    echo "monitor=,preferred,auto,1" > ~/.config/hypr/custom.conf
  fi
  
  cursorposx=$(hyprctl cursorpos -j 2>/dev/null | gojq '.x' 2>/dev/null) || cursorposx=960
  cursorposy=$(hyprctl cursorpos -j 2>/dev/null | gojq '.y' 2>/dev/null) || cursorposy=540
  screensizey=$(hyprctl monitors -j 2>/dev/null | gojq '.[0].height' 2>/dev/null) || screensizey=1080
  cursorposy_inverted=$((screensizey - cursorposy))
  
  swww img "$imgpath" --transition-step 100 --transition-fps 60 \
    --transition-type grow --transition-angle 30 --transition-duration 2 \
    --transition-pos "$cursorposx, $cursorposy_inverted"
  
  # Use Quickshell colorgen instead of AGS
  if [ -f ~/.config/quickshell/ii/scripts/colors/colorgen.sh ]; then
    ~/.config/quickshell/ii/scripts/colors/colorgen.sh "${imgpath}" --apply --smart
  fi
  
  if [ $? -eq 0 ]; then
    touch ~/.local/share/initialSetup
    reboot
  fi
fi
