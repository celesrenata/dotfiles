#!/bin/bash

yay -S --needed --noconfirm touchegg-git gnome-pie-git wofi rsync
sudo systemctl enable touchegg
sudo systemctl start touchegg
rsync -aHx .confg/ $HOME/.config/
