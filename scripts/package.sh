#!/bin/sh

main() {
    echo "Updating system.."
    yay -Syyu --noconfirm

    echo "Installing packages.."
    cat /tmp/dotfiles_360/list-packages.txt | awk '$3 == "p"' | awk '{print $1}' > /tmp/dotfiles_360/pacman
    sudo pacman -S --needed - < /tmp/dotfiles_360/pacman

    cat /tmp/dotfiles_360/list-packages.txt | awk '$3 == "a"' | awk '{print $1}' > /tmp/dotfiles_360/aur
    yay -S --needed --noconfirm - < /tmp/dotfiles_360/aur

    echo "Removing packages..."
    cat /tmp/dotfiles_360/list-packages.txt | awk '$3 == "r"' | awk '{print $1}' > /tmp/dotfiles_360/uninstall
    for x in $(cat /tmp/dotfiles_360/uninstall); do sudo pacman -Rns $x; done
}

main
