#!/usr/bin/env bash


## Synchronizing System Clock!

timedatectl set-ntp true
timedatectl set-timezone America/New_York
hwclock --systohc


## Updating Mirrors

reflector --country 'United States' --sort rate --age 8 --save /etc/pacman.d/mirrorlist


## Wiping Disks and Paritions / Re-Partitioning Disks

dd if=/dev/zero of=/dev/sda bs=16M status=progress && sync
cfdisk /dev/sda

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2


## Mounting Disks and Paritions

mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi


## Base Installation and Generating fstab

pacstrap /mnt base base-devel linux-zen linux-firmware nano sudo
genfstab -U /mnt >> /mnt/etc/fstab


## Coping files and Executing Post Installation Script

cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist
cp Post-Install.sh /mnt/Post-Install.sh
arch-chroot /mnt ./Post-Install.sh


## Removing Installation Script

rm -rf /mnt/Post-Install.sh