#!/bin/sh

# TODO : Script ini belum sama sekali pernah dicoba, suatu saat nanti 'test' script ini.

if [[ ! -d ~/.dotfiles/home ]]; then
    git clone https://github.com/Qois-69912/dotfiles_360 ~/.dotfiles
fi

echo $(tput bold && tput setaf 6)Updating the system$(tput sgr 0)
yay -Syyu --noconfirm

echo "$(tput bold && tput setaf 6)Installing packages$(tput sgr 0)"
cat ~/.dotfiles/list-packages.txt | awk '$3 == "a"' | awk '{print $1}' > /tmp/aur
cat ~/.dotfiles/list-packages.txt | awk '$3 == "p"' | awk '{print $1}' > /tmp/pacman
sudo pacman -S --needed - < /tmp/pacman
yay -S --noconfirm - < /tmp/aur

echo "$(tput bold && tput setaf 6)Sync configuration to host system$(tput sgr 0)"
cp -a ~/.dotfiles/home/. $HOME

echo "$(tput bold && tput setaf 6)Change shell to bash (require root)$(tput sgr 0)$1"
sudo chsh -s /bin/bash
sudo ln -sf dash /bin/sh

echo "$(tput bold && tput setaf 6)Setup rustup$(tput sgr 0)"
rustup default stable && rustup default toolchain
rustup component add rust-src
