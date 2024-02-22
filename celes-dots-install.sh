#!/bin/bash

yay -S --needed --noconfirm touchegg-git gnome-pie-git
sudo systemctl enable touchegg
sudo systemctl start touchegg
