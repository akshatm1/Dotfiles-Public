#!/bin/bash
# archlinux_installation.sh - Minimal Arch Linux installation script ONLY for Virtual Machines
# Now with interactive logging and progress messages.

set -e

LOGFILE="$HOME/arch_install.log"
exec > >(tee -a "$LOGFILE") 2>&1

echo "===== ARCH LINUX INSTALL STARTED: $(date) ====="

DISK="/dev/vda"

echo "[*] Wiping $DISK..."
sgdisk --zap-all "$DISK"

echo "[*] Creating partitions..."
parted -s "$DISK" mklabel gpt

# EFI system partition
echo "[*] Creating EFI partition..."
parted -s "$DISK" mkpart ESP fat32 1MiB 513MiB
parted -s "$DISK" set 1 esp on

# Swap partition (2G, adjust if needed)
echo "[*] Creating swap partition..."
parted -s "$DISK" mkpart primary linux-swap 513MiB 2561MiB

# Root partition (rest of the disk)
echo "[*] Creating root partition..."
parted -s "$DISK" mkpart primary ext4 2561MiB 100%

echo "[*] Formatting partitions..."
mkfs.fat -F32 ${DISK}1
mkswap ${DISK}2
mkfs.ext4 -F ${DISK}3

echo "[*] Mounting root..."
mount ${DISK}3 /mnt
mkdir -p /mnt/boot
mount ${DISK}1 /mnt/boot

echo "[*] Enabling swap..."
swapon ${DISK}2

echo "[*] Partitions created, formatted, and mounted under /mnt."

echo "[*] Installing base packages with pacstrap..."
pacstrap -K /mnt base linux linux-firmware networkmanager neovim grub efibootmgr sudo openssh sed

echo "[*] Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

echo "[*] Entering chroot to configure system..."
arch-chroot /mnt /bin/bash <<EOF

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

# Uncomment en_US.UTF-8 in locale.gen
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

# Generate the locales
locale-gen

# Write default locale to /etc/locale.conf
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Set keyboard layout
echo "KEYMAP=dvorak" > /etc/vconsole.conf

# Set hostname
echo "archlinux" > /etc/hostname

# Set root password
echo "root:arch" | chpasswd

# Create user
useradd -m -G wheel -s /bin/bash akshat
echo "akshat:arch" | chpasswd

# Enable sudo for wheel group
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Install GRUB (UEFI)
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

EOF

echo "[*] Leaving chroot."

echo "[*] Unmounting partitions..."
umount -R /mnt

echo "===== ARCH LINUX INSTALL FINISHED: $(date) ====="
echo "[*] Log stored at $LOGFILE"

