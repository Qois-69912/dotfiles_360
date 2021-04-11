#! /bin/sh

# === Functions === #
# == General functions == #
# Error message function
error() { printf "ERROR: %s\\n" "$1" && exit 1;} 

# Menu
menu() {
    echo "what do you want to do ?"
    printf " 1) Configure base stuff\\n 2) Configure printer stuff [incoming]\\n 3) Configure browser stuff\\n 4) Exit\\n"
    read -n 1 -p "Your choice : " chc;
    case $chc in 
        1)
            basestuff;;
        2)
            menu;;
        3)
            browserstuff;;
        4)
            printf "\\n" && exit;;
        *)
            printf "\033[1;31mError\033[0m : Pilihannya hanya 1,2,3 atau 4\\n\\n" && sleep 2 && menu;;
    esac
}

# Configuring base stuff
basestuff() {
    updatepackages && installingpackages && uninstallpackages
    deployfiles && createfolder && sshcreate
    menu
}

# Configuring browser stuff
browserstuff() {
    echo "What do you want to do ?"
    printf " 1) Backup the files\\n 2) Put the backup files\\n 3) exit\\n"
    read -n 1 -p "Your choice : " chc;
    case $chc in 
        1)
            backupbrowser;;
        2)
            putbrowser;;
        3)
            menu;;
        *)
            printf "\033[1;31mError\033[0m : Pilihannya hanya 1,2,3 atau 4\\n\\n" && sleep 2 && menu;;
    esac
}


# == Root functions == #
# Update packages
updatepackages() {
    sudo pacman -Syyu --noconfirm
}

# Install packages
installingpackages() {
    # Pacman
    sudo pacman -S --noconfirm \
        `# Browser` \
        brave \
        \
        `# Font` \
        ttf-droid              `# Font for monospace` \
        \
        `# XFCE stuff` \
        xfce4 \
        papirus-icon-theme          `# Icon theme` \
        arc-gtk-theme               `# Theme theme` \
        xfce4-notifyd \
        xfce4-taskmanager \
        xfce-pulseaudio-plugin \
        xfce4-whiskermenu-plugin \
        \
        `# Multimedia` \
        evince                  `# Document viewer` \
        audacious               `# Music player` \
        mpv                     `# Video viewer` \
        flameshot               `# Screenshot` \
        nomacs                  `# Photo viewer` \
        \
        `# Utillities` \
        termite                 `# Terminal` \
        git \
        redshift                `# Warm light for screen` \
        ffmpeg \
        pavucontrol             `# Volume Control` \
        unzip \
        neovim \
        xclip                   `# Clipboard` \ 
        gvfs                    `# Able to automount usb` \
        polkit-gnome            `# dependencies for gvfs` \
        android-file-transfer

    ## Aur
    sudo yay -S --noconfirm \
        ttf-times-new-roman \
        zoom
}

# Uninstalling packages
uninstallpackages() {
    sudo pacman -Rns --noconfirm \
        xfce4-terminal          
}


# User functions
# Deploy dotfiles
deployfiles() {
    git clone --separate-git-diir=$HOME/.dotfiles https://github.com/Qois-69912/dotfiles_360.git tmpdotfiles
    rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
    rm -rf tmpdotfiles
}

# Creating folder
createfolder() {
    if [[ $EUID != 0 ]]; then
        mkdir ~/Picture 
    else 
        error "To perform this functions, you must not be root"
    fi
}

# ssh stuff
sshcreate() {
    read -n 1 -p "Your email : " val;
    email="\"$val\""
    ssh-keygen -t ed25519 -N '' -C $email -f $HOME/.ssh/id_ed25519
    xclip -sel clip < ~/.ssh/id_ed25519.pub
    echo "ssh key-nya sudah disalin, tinggal dipaste di github atau website lainnya"
}

# Backup browser file
backupbrowser() {
    # Path
    printf "Where to put the backup of this files (idealnya pathnya adalah usb) ? \\n"
    read -n 1 -p "path: " backuplocation;

    # Browser
    if [ -f ~/.mozilla ]; then 
        cp -r ~/.mozilla $backuplocation 
    fi
    if [ -f ~/.config/BraveSoftware ]; then 
        cp -r ~/.config/BraveSoftware $backuplocation 
    fi
}

# Put the backup browser file
putbrowser() {
    printf "Where is the firefox backup ? "
    read -n 1 -p "path: " firefoxlocation;

    printf "Where is the brave backup ? "
    read -n 1 -p "path: " bravelocation;

    cp -r $firefoxlocation ~
    cp -r $bravelocation ~/.config/
}



# === Main === #
# Checking for internet connection
ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` > /dev/null || error "Tidak ada internet koneksi"

menu
