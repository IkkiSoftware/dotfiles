# dotfiles

## Getting Started

### Prerequisites

- An Arch based operating system (only required for the installation with the script)
- `curl` or `wget` should be installed
- `git`

### Basic Installation

If you start from scratch (no software installed) you can invoke the following command. It will install the required software
and clone this repo.

| Method    | Command                                                                                           	|
| :-------- | :-----------------------------------------------------------------------------------------------------|
| **curl**  | `sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/IkkiSoftware/dotfiles/main/install.sh )"` |
| **wget**  | `sudo sh -c "$(wget -O- https://raw.githubusercontent.com/IkkiSoftware/dotfiles/main/install.sh )"`   |

List of the software installed :
- zsh
- pavucontrol
- pulseaudio
- feh
- i3-gaps
- i3lock
- polybar
- rofi
- alacritty
- neovim
- clang

If you just want the configuration files, clone the repo with the following command :

`git clone https://github.com/IkkiSoftware/dotfiles.git $HOME/.config/`

### Neovim

If you don't install with the script, run the following command:

`git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim`

Be sure to have the clang compiler :

`sudo pacman -S clang`

