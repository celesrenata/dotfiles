#!/usr/bin/env bash
imgpath=~/Backgrounds/love-is-love.jpg

if ! [ -f ~/.local/share/initialSetup ]; then
  rsync -azL --no-perms ~/.configstaging/ ~/.config 2> /dev/null
  mkdir -p ~/.local/share
  mkdir -p ~/.config/foot
  mkdir -p ~/.config/fuzzel
  mkdir -p ~/.config/hypr/custom/scripts
  mkdir -p ~/.config/matugen/templates/kde
  mkdir -p ~/.local/state/quickshell/user/generated/{foot,terminal,fuzzel}
  mkdir -p ~/Videos
  
  # Set proper permissions for generated config files
  chmod -R u+w ~/.local/state/quickshell/user/generated/ ~/.config/fuzzel/ ~/.config/foot/ ~/.config/matugen/ 2>/dev/null || true
  
  # Preserve existing custom.conf or create default
  if [ ! -f ~/.config/hypr/custom.conf ]; then
    echo "monitor=,preferred,auto,1" > ~/.config/hypr/custom.conf
  fi
  
  # Generate and apply color scheme using Quickshell's colorgen
  if [ -f ~/.config/quickshell/ii/scripts/colors/colorgen.sh ]; then
    ~/.config/quickshell/ii/scripts/colors/colorgen.sh "${imgpath}" --apply --smart
  fi
  
  if [ $? -eq 0 ]; then
    touch ~/.local/share/initialSetup
    reboot
  fi
fi
