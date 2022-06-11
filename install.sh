#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

distro=$(cat /etc/os-release | grep "^ID=" | cut -d "=" -f2)
if [ "$distro" != "arch" ]; then
	echo "Only Arch distro supported for now"
	exit
fi

#pacman -S i3-gaps i3lock neovim alacritty polybar rofi git wget curl


