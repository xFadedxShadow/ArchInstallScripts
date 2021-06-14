#!/usr/bin/env bash


## Configuring Timzone and System Clock

ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc


## Generating Locales and Configuring Host Files

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "null" > /etc/hostname
echo -e '127.0.0.1       localhost\n::1             localhost\n127.0.1.1       null' > /etc/hosts


## Installing Extra Packages and Configuring GRUB

pacman -S grub efibootmgr networkmanager network-manager-applet dialog mtools dosfstools linux-zen-headers bluez bluez-utils alsa-utils pulseaudio pulseaudio-bluetooth git reflector xdg-utils xdg-user-dirs bash-completion intel-ucode
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg


## Enabling System Services

systemctl enable NetworkManager
systemctl enable bluetooth


## Creating Users and Configuring Groups

useradd -mG wheel xfadedxshadow
EDITOR=nano visudo
echo "Enter Root Password"
passwd
echo "\nEnter User Password!"
passwd xfadedxshadow


## Installtion Completed!

echo "Installation is complete!\nSetup a Graphical Enviorment, Display Server and Login Manager of your choice!"