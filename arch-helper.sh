#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/arch-helper"
CONFIG_FILE="$CONFIG_DIR/config"

mkdir -p "$CONFIG_DIR"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Contact @ihateubuntu#8577 on fluxus for help."
    echo ""
    read -rp "Do you have yay installed? (yes/no): " USER_OPTION
    echo "USER_OPTION=\"$USER_OPTION\"" > "$CONFIG_FILE"
    echo "Saved! This won't be asked again."
    sleep 1
else
    source "$CONFIG_FILE"
fi

main() {
    clear
    cat <<EOF
                 _           _          _                 
                | |         | |        | |                
   __ _ _ __ ___| |__ ______| |__   ___| |_ __   ___ _ __ 
  / _\` | '__/ __| '_ \______| '_ \ / _ \ | '_ \ / _ \ '__|
 | (_| | | | (__| | | |     | | | |  __/ | |_) |  __/ |   
  \__,_|_|  \___|_| |_|     |_| |_|\___|_| .__/ \___|_|   
                                         | |              
                                         |_|              
EOF
    echo "choose a package to install via: "
    echo ""
    echo "[1] AUR"
    echo "[2] Pacman"
    echo ""
    read -rp ">> " OPT
    if [[ "$OPT" == "1" ]]; then
       clear
       read -rp "Package name: " PKG  
       sleep 1
       clear
       echo "[*] Installing package.."
       yay -S "$PKG"
       clear
       echo "[ ok ] Finished!, returning.."
       sleep 1
       main
    elif [[ "$OPT" == "2" ]]; then
       clear
       read -rp "Package name: " PACKAGE
       sleep 1
       clear
       echo "[*] Installing package.."
       sudo pacman -S "$PACKAGE"
       clear
       echo "[ ok ] Finished!, returning.."
       sleep 1
       main
    else
       exit
    fi
}

if [[ "$USER_OPTION" == "yes" ]]; then
    main
else
    echo "[*] Installing packages.."
    sleep 2
    sudo pacman -S autoconf automake binutils bison debugedilt fakeroot file findutils flex gawk gcc gettext grep groff gzip unzip libtool m4 make patch pkgconf sed sudo texinfo which git go gcc
    clear
    echo "[*] Installing yay.."
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin || exit
    makepkg -si
    cd ..
    echo "[ ok ] Finished installing yay!"    
    sleep 2
    main
fi
