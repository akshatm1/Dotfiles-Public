#!/bin/bash
# bootstrap.sh – Arch + Hyprland dotfiles bootstrap with logging

set -e  # exit on first error

LOGFILE="$HOME/bootstrap.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "===== BOOTSTRAP STARTED: $(date) ====="

echo "[*] Updating system..."
sudo pacman -Syu --noconfirm

echo "[*] Checking for git..."
if ! command -v git &>/dev/null; then
    sudo pacman -S --needed --noconfirm git
fi

echo "[*] Installing compiling tools (base-devel, cmake, etc.)..."
sudo pacman -S --needed --noconfirm base-devel cmake make gcc

echo "[*] Checking for yay..."
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

echo "[*] Installing Oh My Bash..."
if [ ! -d "$HOME/.oh-my-bash" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" || true
fi

echo "[*] Installing official packages (pacman)..."
sudo pacman -S --needed --noconfirm \
    base base-devel \
    networkmanager bluez bluez-utils pipewire-alsa pipewire-jack pulseaudio pavucontrol wireplumber \
    git github-cli sudo wget curl unzip unrar \
    alacritty thunar firefox evince neovim \
    fastfetch htop \
    grim wl-clipboard xclip tumbler \
    brightnessctl pamixer

echo "[*] Installing AUR packages (yay)..."
yay -S --needed --noconfirm \
    hyprland-workspaces \
    waybar rofi swww dunst pywal \
    papirus-icon-theme catppuccin-gtk-theme-mocha lxappearance gtk-engine-murrine \
    aylurs-gtk-shell-git bibata-cursor-theme-bin \
    ttf-fira-code ttf-firacode-nerd ttf-jetbrains-mono ttf-dejavu-nerd \
    otf-font-awesome

echo "[*] Cloning dotfiles repo..."
if [ ! -d "$HOME/Dotfiles-Public" ]; then
    git clone https://github.com/akshatm1/Dotfiles-Public.git "$HOME/Dotfiles-Public"
else
    echo "Repo already exists at $HOME/Dotfiles-Public, skipping clone."
fi

echo "===== BOOTSTRAP FINISHED: $(date) ====="
echo "[*] Log stored at $LOGFILE"

