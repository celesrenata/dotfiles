#!/bin/bash

yay -S --needed --noconfirm touchegg-git gnome-pie-git wofi rsync cairo-dock-plug-ins-wayland-git
sudo systemctl enable touchegg
sudo systemctl start touchegg
rsync -aHx .confg/ $HOME/.config/
mkdir ~/sources
cd ~/sources
git clone https://github.com/RedBearAK/toshy.git
cd toshy
./setup_toshy.py install --override-distro arch
rm -rf ~/.config/cairo-dock/current_theme/plug-ins/switcher/
