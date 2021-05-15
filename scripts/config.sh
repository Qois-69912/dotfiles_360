#!/bin/sh
pac_package=""
yay_package=""
target=""

check_dependencies() {
    if ! command -v git "$1"; then 
        echo "Tidak ada program $1, nanti akan diinstall"
        pac_package="$pac_package $1"
    fi
}

install_dependencies() {
    if ! [ -z "${pac_package}" ]; then
        echo "Installing all the dependencies (require root)"
        sudo pacman $pac_package
    fi

    if ! [ -z "${yay_package}" ]; then
        echo "Installing all the dependencies (require root) [aur]"
        yay -S $yay_package
    fi

    if [[ -z "${pac_package}" && -z "${yay_package}" ]]; then
        echo "Tidak ada hal yang harus diinstall"
    fi
}

installasi_config() {
    # Catatan : Jangan check apakah file ada atau tidak, sebab
    # bila file ada, maka tidak bisa men-rewrite config lama dgn yang baru

    echo "Installasi config $1"
    
    # Skenario khusus untuk beberapa file
    # bashrc
    if $1 == "bashrc" &> /dev/null; then
        # Memastikan apakah shell mengunakan bash
        if echo $0 != "/bin/bash" &> /dev/null; then
            echo "Change shell to bash (require root)"
            sudo chsh -s /bin/bash
        fi

    # gitconfig
    elif $1 == "gitconfig" &> /dev/null; then
        check_dependencies git 

    # alacritty
    elif $1 == "alacritty.yml" &> /dev/null; then
        check_dependencies alacritty

    # redshift
    elif $1 == "redshift.conf" &> /dev/null; then
        check_dependencies redshift
    fi

    # Target dimana config akan disimpan
    target="$2"

    # Membuat dir, kalau belum ada
    if [[ $3 == "dir" ]]; then
        if ! [[ -d $2 ]]; then
            mkdir $2
        fi

    # Merename file, menjadi '.'file
    elif [[ $3 == "dot" ]]; then
        target="$2/.$1"
    fi

    # Nanti 'dotfiles/$1' diganti dengan '/tmp/'
    cp dotfiles/$1 $target
}

main() {
    echo "Installasi configurasi..."
    echo "Warning!!, ini akan menyebabkan configurasi yang sekarang terhapus"

    # Installasi config
    installasi_config bashrc $HOME dot
    installasi_config gitconfig $HOME dot
    installasi_config alacritty.yml $HOME/.config/alacritty dir
    installasi_config redshift.conf $HOME/.config
    installasi_config xprofile $HOME dot

    # Installasi dependencies
    install_dependencies
}

main
