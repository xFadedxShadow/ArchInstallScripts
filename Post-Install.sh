#!/usr/bin/env bash


## Setting up timezone and Hardware Clock.

ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc


## Setting up Locales, Hostname and Hosts.

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "null" > /etc/hostname
echo -e '127.0.0.1       localhost\n::1             localhost\n127.0.1.1       null' > /etc/hosts


## Installing System Packages and Configuring bootloader.

pacman -S grub efibootmgr networkmanager network-manager-applet dialog mtools dosfstools linux-zen-headers bluez bluez-utils alsa-utils pulseaudio pulseaudio-bluetooth git reflector xdg-utils xdg-user-dirs bash-completion intel-ucode
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg


## Enabling system services.

systemctl enable NetworkManager
systemctl enable bluetooth


## Adding users and Editing sudo

useradd -mG wheel xfadedxshadow
EDITOR=nano visudo
echo "Enter Root Password!"
passwd
echo "Enter User Password!"
passwd xfadedxshadow


echo "Installation has been completed! ( Setup a Graphical Enviorment and a Display Server!"
exit