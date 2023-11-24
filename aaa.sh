#!/bin/sh
# Arthur's Arch linux Auto-installer (AAA)

# Colors
INFO='\e[34m[#]\e[0m'
SUCCESS='\e[32m[+]\e[0m'
WAIT='\e[33m[*]\e[0m'
FAIL='\e[31m[-]\e[0m'
QUESTION='\e[35m[?]\e[0m'

function installer {
    # Set up system time
        # echo -e "${INFO} STARTING LOCALIZATION ${INFO}"
        # (Automatically detect region and respective keymap and timezone)
        # localectl list-keymaps | grep keymap
        # loadkeys ${keymap}
        # timedatectl list-timezones | grep region
        # ln -sf /usr/share/zoneinfo/{region} /etc/localtime
        # timedatectl set-ntp true

    # Disk partitioning (ask size for boot [default = +350M], linux [default = -50G])
        # echo -e "${INFO} PARTITIONING DISK ${INFO}"

    # Format partitions (boot [default = vfat])
        # echo -e "${INFO} FORMATING DISK ${INFO}"
        # mkfs.vfat /dev/nvme0n1p1

    # Encrypt (ask for encryption password)
        # echo -e "${INFO} ENCRYPTING PARTITIONS ${INFO}"
        # cryptsetup luksFormat /dev/nvme0n1p2
        # echo -sne "${QUESTION} Please insert encryption password: "
        # read encryptionpass
        # ...
        # {SET UP BTRFS SUBVOLUMES}
        # {MOUNT FILESYSTEMS}

    # Install arch (pacstrap - ask for drivers)
        # echo -e "${INFO} INSTALLING ARCH ${INFO}"
        # pacstrap /mnt base linux linux-firmware git vim intel-ucode btrfs-progs
        # genfstab -U /mtn >> /mnt/etc/fstab
        # arch-chroot /mnt
        # ln -sf /usr/share/zoneinfo/{region} /etc/localtime
        # {UNCOMMENT DESIRED LOCALES, will probably use sed}

    # Set up account passwords (root - user [ask if should be root] - boot)
        # Ask if user wants to set up hostname and account (y/N)
        # echo -e "${INFO} SETTING UP ACCOUNTS ${INFO}"
        # echo -ne "${QUESTION} Please insert hostname: "
        # read {hostname:=archlinux} > /etc/hostname
        # echo -sne "${QUESTION} Please insert root password: "
        # read userpassword
        # echo -ne "${QUESTION} Please insert username: "
        # read username
        # echo -sne "${QUESTION} Please insert ${user}'s account password: "
        # read userpassword

    # Set up encrypted swap
        # echo -e "${INFO} ENCRYPTING SWAP ${INFO}"
}

function adjuster {
    echo -e "${INFO} DOWNLOADING REGULAR PACKAGES ${INFO}"

    echo -ne "${QUESTION} Please choose a profile option: 
    0. None
    1. Minimal (dwm w/personal dotfiles)
    2. Desktop (Gnome)
    > "
    read profile

    case $profile in
        1) echo -e "${WAIT} Adjusting towards a minimal environment..."
           sudo pacman -Sy --noconfirm libx11 libxft libxinerama freetype2 fontconfig ttf-dejavu xorg-server xorg-xinit xorg-xsetroot feh lf neomutt newsboat monerod monero-wallet-cli &&\
           git clone https://github.com/arthurmateu/dotfiles.git &&\
           cd dotfiles/dwm && sudo make clean install &&\
           cd ../dmenu && sudo make clean install &&\
           cd ../st && sudo make clean install &&\
           mv ../.vimrc ../.zshrc ~/. && cd ~ &&\
           echo "dwm&" >> .xinitrc &&\
           echo "# feh --bg-fill Pictures/ &" >> .xinitrc &&\
           echo -e "${SUCCESS} Succesfully adjusted minimal environment" || default_error;;
        2) echo -e "${WAIT} Adjusting towards a desktop environment..."
           # TODO: actually install gnome
           # sudo pacman -Sy --noconfirm gnome thunderbird monero signal-desktop &&\
           # echo -e "${SUCCESS} Succesfully adjusted desktop environment" || default_error;;
        *) echo -e "${INFO} No profile has been chosen.";;
    esac

    echo -e "${WAIT} Installing regular packages..."
    sudo pacman -Sy --noconfirm base-devel vim neofetch mpv htop firefox networkmanager webkit2gtk man-db qbittorrent cherrytree keepassxc cups &&\
    echo -e "${SUCCESS} Succesfully installed packages" || default_error
    echo -e "${WAIT} Adjusting printer..."
    sudo systemctl enable --now cups &&\
    # TODO: if there's a non-root user, add it to the group
    # sudo usermod -aG lp ${username} &&\
    echo -e "${SUCCESS} Succesfully enabled printer" || default_error

    echo -e "${WAIT} Installing QEMU components..."
    sudo pacman -Sy --noconfirm qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs xclip &&\
    echo -e "${SUCCESS} Succesfully installed QEMU components" || default_error
    echo -e "${WAIT} Setting up QEMU..."
    sudo systemctl enable --now libvirtd.service &&\
    # TODO: if there's a non-root user, add it to the group
    # sudo usermod -aG libvirt ${username} &&\
    sudo systemctl restart libvirtd.service &&\
    echo -e "${SUCCESS} Succesfully setted up QEMU" || default_error

    echo -e "${WAIT} Installing yay..." # AUR Helper
    mkdir /tmp/yay &&\
    cd /tmp/yay &&\
    git clone https://aur.archlinux.org/yay.git &&\
    cd yay/ &&\
    makepkg -si &&\
    cd ~ &&\
    rm -rf /tmp/yay
    echo -e "${SUCCESS} Succesfully installed yay" || default_error
    # TODO: Download specific AUR packages, depending on profile (minimal/desktop)
        # MINIMAL: yay -Syu mullvad-vpn-cli signal-cli
        # DESKTOP: yay -Syu mullvad-vpn spotify discord megasync &&\
    # echo -e "${WAIT} Installing AUR packages..."
    # echo -e "${SUCCESS} Succesfully installed AUR packages" || default_error
}

function default_error {
    echo -e "${FAIL} An error has ocurred.
    Skipping...
    "
}


echo -ne "${INFO} Welcome!
Would you like to:
1. Install Arch Linux
2. Install Regular Packages and Adjust
3. Both
4. Neither
> "
read welcome_option

case $welcome_option in
    1) installer;;
    2) adjuster;;
    3) installer && adjuster;;
    *) exit 0;
esac