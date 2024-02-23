#!/bin/bash

mkdir -p ~/sources/{end-4,celes}
cd ~/sources/end-4
git clone https://github.com/end-4/dots-hyprland.git
cd dots-hyprland
./install.sh
cd ~/
yay -S --needed --noconfirm touchegg-git gnome-pie-git wofi rsync cairo-dock-plug-ins-wayland-git
sudo systemctl enable touchegg
sudo systemctl start touchegg
rsync -aHx .confg $HOME
cd ~/sources
git clone https://github.com/RedBearAK/toshy.git
cd toshy
./setup_toshy.py install --override-distro arch
rm -rf ~/.config/cairo-dock/current_theme/plug-ins/switcher/
