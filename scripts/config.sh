#!/bin/sh
target=""

installasi_config() {
    # Catatan : Jangan check apakah file ada atau tidak, sebab
    # bila file ada, maka tidak bisa men-rewrite config lama dgn yang baru

    echo "$(tput bold && tput setaf 6)Installasi config$(tput sgr 0) $1"
    
    # Skenario khusus untuk beberapa file
    # bashrc
    if [ "$1" = "bashrc" ]; then
        # Memastikan apakah shell mengunakan bash
        if [ "$(echo $SHELL)" != "/bin/bash" ]; then
            echo "$(tput bold && tput setaf 6)Change shell to bash (require root)$(tput sgr 0)$1"
            sudo chsh -s /bin/bash
            sudo ln -sf dash /bin/sh
        fi
    fi

    # Target dimana config akan disimpan
    target="$2"

    # Membuat dir, kalau belum ada
    if [ "$3" = "dir" ]; then
        if ! [ -d $2 ]; then
            mkdir $2
        fi

    # Merename file, menjadi '.'file
    elif [ "$3" = "dot" ]; then
        target="$2/.$1"
    fi

    # Mencopy config ke tempat yang benar
    cp /tmp/dotfiles_360/dotfiles/$1 $target
}

main() {
    echo "$(tput bold && tput setaf 6)Installasi configurasi$(tput sgr 0)"
    echo "$(tput bold && tput setaf 1)Warning!!$(tput sgr 0), ini akan menyebabkan configurasi yang sekarang terhapus"

    # Installasi config
    installasi_config bashrc $HOME dot
    installasi_config gitconfig $HOME dot
    installasi_config xprofile $HOME dot

    installasi_config redshift.conf $HOME/.config
    installasi_config alacritty.yml $HOME/.config/alacritty dir
    installasi_config fonts.conf $HOME/.config/fontconfig dir
}

main
