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

#pacman -S zsh i3-gaps i3lock neovim alacritty polybar rofi pavucontrol pulseaudio feh clang


HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
REPO=${REPO:-IkkiSoftware/dotfiles}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

command_exists git || {
    echo "git is not installed"
    exit 1
}

git clone $REMOTE "$HOME/.config/"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
