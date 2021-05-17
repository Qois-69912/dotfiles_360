#!/bin/sh
# 'install.sh' adalah script primary (utama) yang nanti akan menjalankan script lainnya.
# Masing - masing script yang dijalankan mempunyai tujuan tersendiri.
# Tempat script lainnya akan berada didirectori 'script'.

install_dotfiles() {
    echo "Clonning repository"
    if [ -e "/tmp/dotfiles_360" ]; then
        rm -rf /tmp/dotfiles_360
    fi
    git clone https://github.com/Qois-69912/dotfiles_360 /tmp/dotfiles_360 2> /dev/null
    sh /tmp/dotfiles_360/scripts/config.sh
}

main() {
    if [ "$1" = "-i" ]; then
        echo "Installing dotfiles.."
        install_dotfiles
    else
        echo "Install script for dotfiles"
        echo "Usage : sh install.sh [options] [path-to-target]"
        echo " "
        echo "Options : "
        echo "-i    Install Dotfiles dari repository dotfiles"
        echo "-b    Backup config yang sekarang ada ke repository-nya dotfiles"
        echo " "
        echo "Path-to-target => hanya untuk options '-b'"
        echo " "
    fi
}

main $1
