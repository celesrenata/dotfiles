#!/bin/bash

OPWD=$(pwd)
if [ "$1" == "--toshy" ]; then
	cd ~/sources
	git clone https://github.com/RedBearAK/toshy.git

	cd toshy
	./setup_toshy.py install --override-distro arch
	echo ""
	echo "Do not forget to click the rainbow '󰘳' and select the Apple keyboard! until you add yours properly."
	exit
fi

GCCVER=$(gcc --version | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" | awk -F '.' '{ print $1 }' )
sudo pacman -S wget --needed --noconfirm
if ! [ -f "/opt/gcc13/bin/gcc" ]; then
	if [ $GCCVER -lt 13 ]; then
		./build-gcc13.sh
	fi
fi
rm -rf ~/sources/end-4
mkdir -p ~/sources/{end-4,celes}
cd ~/sources/end-4
git clone https://github.com/end-4/dots-hyprland.git
cd dots-hyprland
git checkout a6a8c8dc6a1774dd44cb88c93d9abfb2a3e7947b
if [ $GCCVER -lt 13 ]; then
        CC=/opt/gcc13/bin/gcc CXX=/opt/gcc13/bin/g++ yay -S hyprlang --needed --noconfirm
	CC=/opt/gcc13/bin/gcc CXX=/opt/gcc13/bin/g++ ./install.sh
	CC=/opt/gcc13/bin/gcc CXX=/opt/gcc13/bin/g++ ./update-ags.sh
else
	echo "gcc13 already installed"
	yay -S hyprlang --needed --noconfirm
	./install.sh
	./update-ags.sh
fi
cd ~/
yay -S --needed --noconfirm touchegg-git gnome-pie-git wofi rsync cairo-dock-plug-ins-wayland-git network-manager-applet touche blueman wofi-calc
rm -rf ~/.config/cairo-dock/current_theme/plug-ins/switcher/
rsync -aHx ${OPWD}/.config ~/
touch ~/.config/hypr/custom/env.conf
touch ~/.config/hypr/custom/rules.conf
cp ~/.config/hypr/hyprland/general.conf ~/.config/hypr/custom/general.conf
sudo systemctl enable touchegg
sudo systemctl start touchegg
grep "LD_LIBRARY_PATH=/opt/gcc13/lib64" /etc/environment -q
if [ $? -ne 0 ]; then
	echo "LD_LIBRARY_PATH=/opt/gcc13/lib64" | sudo tee -a /etc/environment
fi
patch ~/.config/hypr/custom/general.conf ${OPWD}/general.conf.patch
patch ~/.config/hypr/hyprland.conf ${OPWD}/hyprland.conf.patch

echo ""
echo "you will want to reboot now and rerun this command with the --toshy switch from within Hyprland."
echo "The embedded cheatsheat is accessible via Super + Alt/Option + /"
echo "Please remember, without toshy running and your keyboard configured or the override to 'Apple' set in toshy prefernces that your Super is 'Control' until enabled!"
echo "Good luck!"
