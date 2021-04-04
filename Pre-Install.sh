#!/usr/bin/env bash


## Synchronizing System Clock. ( Silencing NTP / Causes Weird Issues )

timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc


## Setting up mirrors list.

reflector --country 'United States' --sort rate --age 8 --save /etc/pacman.d/mirrorlist


## Wiping and Partitioning Disks and Formatting. ( Block Size 16 MB )

dd if=/dev/zero of=/dev/sda bs=16M status=progress && sync
cfdisk /dev/sda
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2


## Mounting Disks and Creating Directories.

mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi


## Installing Base Arch Packages and Generating fstab.

pacstrap /mnt base base-devel linux-zen linux-firmware nano sudo
genfstab -U /mnt >> /mnt/etc/fstab


## Coping files into the new system and running it.

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
cp Post-Install.sh /mnt/Post-Install.sh
arch-chroot /mnt ./Post-Install.sh


## Deleting scripts..

rm -rf /mnt/Post-Install.sh
