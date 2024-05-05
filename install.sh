#!/bin/bash

# Check if script is run as root
if [[ "$(id -u)" -eq 0 ]]; then
  echo "This script must not be run as root"
  exit 1
fi

# Update system 
sudo pacman -Syu

sudo pacman -S --needed base-devel git wget
git clone https://aur.archlinux.org/paru.git
cd paru

makepkg -si
rustup default stable
makepkg -si

paru -Syu base-devel qtile pulseaudio sddm

cd /tmp
mkdir installation
cd installation
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
paru -Syu unzip
unzip JetBrainsMono-2.304.zip
rm -rf AUTHORS.txt JetBrainsMono-2.304.zip OFL.txt

sudo mkdir -p /usr/share/fonts/JetBrainsMono
sudo mv /tmp/installation/fonts/ttf/*.ttf /usr/share/fonts/JetBrainsMono
sudo fc-cache -f -v

paru -Syu zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
