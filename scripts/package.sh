#!/bin/sh

main() {
    echo "$(tput bold && tput setaf 6)Updating system$(tput sgr 0)"
    yay -Syyu --noconfirm

    echo "$(tput bold && tput setaf 6)Installing packages$(tput sgr 0)"
    cat /tmp/dotfiles_360/list-packages.txt | awk '$3 == "p"' | awk '{print $1}' > /tmp/dotfiles_360/pacman
    sudo pacman -S --needed - < /tmp/dotfiles_360/pacman

    cat /tmp/dotfiles_360/list-packages.txt | awk '$3 == "a"' | awk '{print $1}' > /tmp/dotfiles_360/aur
    yay -S --needed --noconfirm - < /tmp/dotfiles_360/aur

    echo "$(tput bold && tput setaf 6)Removing packages$(tput sgr 0)"
    cat /tmp/dotfiles_360/list-packages.txt | awk '$3 == "r"' | awk '{print $1}' > /tmp/dotfiles_360/uninstall
    for x in $(cat /tmp/dotfiles_360/uninstall); do sudo pacman -Rns $x; done
}

main
