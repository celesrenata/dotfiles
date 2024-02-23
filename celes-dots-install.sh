#!/bin/bash

if [ "$1" -eq "--toshy" ]; then
	cd ~/sources
	git clone https://github.com/RedBearAK/toshy.git

	cd toshy
	./setup_toshy.py install --override-distro arch
	exit
fi

sudo pacman -S wget --needed --noconfirm
if ! [ -f "/opt/gcc13/bin/gcc" ]; then
	GCCVER=$(gcc --version | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" | awk -F '.' '{ print $1 }' )
	if [ "${GCCVER}" -lt 13 ]; then
		./build-gcc13.sh
	fi
fi
yay -S hyprlang --needed --noconfirm
mkdir -p ~/sources/{end-4,celes}
cd ~/sources/end-4
git clone https://github.com/end-4/dots-hyprland.git
cd dots-hyprland

if [ "${GCCVER}" -lt 13 ]; then
	CC=/opt/gcc13/bin/gcc CXX=/opt/gcc13/bin/g++ ./install.sh
else
	./install.sh
fi
cd ~/
yay -S --needed --noconfirm touchegg-git gnome-pie-git wofi rsync cairo-dock-plug-ins-wayland-git network-manager-applet
rm -rf ~/.config/cairo-dock/current_theme/plug-ins/switcher/
rsync -aHx .config ~/
sudo systemctl enable touchegg
sudo systemctl start touchegg

grep "LD_LIBRARY_PATH=/opt/gcc13/lib64" /etc/environment -q
if [ $? -ne 0 ]; then
	echo "LD_LIBRARY_PATH=/opt/gcc13/lib64" | sudo tee -a /etc/environment
fi
echo ""
echo "you will want to reboot now and rerun this command with the --toshy switch from within Hyprland."
echo "The embedded cheatsheat is accessible via Super + Alt/Option + /"
echo "Please remember, without toshy running and your keyboard configured or the override to 'Apple' set in toshy prefernces that your Super is 'Control' until enabled!"
echo "Good luck!"
