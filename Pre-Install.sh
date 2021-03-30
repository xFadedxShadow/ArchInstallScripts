#!/usr/bin/env bash


## Synchronizing System Clock.

timedatectl set-ntp true 2>&1 >/dev/null
timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)" 2>&1 >/dev/null
hwclock --systohc


## Setting up mirrors list.

reflector --country 'United States' --sort rate --age 8 --save /etc/pacman.d/mirrorlist 2>&1 >/dev/null


## Wiping and Partitioning Disks and Formatting. (Block Size 16 MB )

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
genfstab -u /mnt >> /mnt/etc/fstab


## Coping script into the new system and running it.

cp Post-Install.sh /mnt
arch-chroot /mnt ./Post-Install.sh


## Deleting scripts..

rm -rf /mnt/Post-Install.sh