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

install_packages() {
    sh /tmp/dotfiles_360/scripts/package.sh
}

main() {
    if [ "$1" = "install" ]; then
        echo "Installing dotfiles.."
        install_packages
        install_dotfiles
    else
        echo "Install script for dotfiles"
        echo "Usage: sh install.sh [options]"
        echo " "
        echo "Options: "
        echo "  install       Install Dotfiles dari repository dotfiles"
    fi
}

main $1
