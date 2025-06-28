---
creationdate:
  - 2025-06-28 19:22
aliases: []
tags:
  - NixOS_proper_Setup
foldertags: 
  - Hobbies Coaching Müller
pathtag:
  - Hobbies/Coaching/Müller
TemplateVersion: 1
---

 **Note created** `=dateformat(this.file.ctime, "yyyy.MM.dd - HH:mm")`
 **Note modified** `=dateformat(this.file.mtime, "yyyy.MM.dd - HH:mm")`
# `= this.file.name`
We will use disko to partition our drive.
We will then install to our drive.

Boot into a live environment (kde is preferrable)
1. Pull your repository
```
git clone https://github.com/tracekotae/.dotfiles
```
2. Move into the flakes directory and stay there for the rest of the installation
```
cd ./.dotfiles/flakes
```
3. Make sure you try to install to the correct disk. Checkout the disks.nix file and use gparted to confirm.
   The whole disk will be erased and reformatted.
4. nix-shell disko and execute it
```
sudo nix-shell -p disko --run "disko --mode disko ./disks.nix"
```
5. mount all created partitions. If you edited disks.nix you also need to accomodate here.
```
sudo mount -t btrfs -o subvol=rootfs /dev/disk/by-partlabel/root /mnt
sudo mkdir -p /mnt/boot /mnt/home /mnt/nix /mnt/persist /mnt/var/log /mnt/.swapvol
sudo mount /dev/disk/by-partlabel/boot /mnt/boot
sudo mount -t btrfs -o subvol=home /dev/disk/by-partlabel/root /mnt/home
sudo mount -t btrfs -o subvol=nix /dev/disk/by-partlabel/root /mnt/nix
sudo mount -t btrfs -o subvol=persist /dev/disk/by-partlabel/root /mnt/persist
sudo mount -t btrfs -o subvol=var/log /dev/disk/by-partlabel/root /mnt/var/log
sudo mount -t btrfs -o subvol=swap /dev/disk/by-partlabel/root /mnt/.swapvol
```
6. make sure that the other harddrives are configured correctly. Disko only considers and sets up the system drive. all harddrives that you want automounted need to be defined. See ./systembase/mountdisks.nix for details. If you are just reinstalling you probably just need to change the UUIDs of the Harddrives.
7. For some ungodly reason go to /systembase/stylix.nix and disable it. Once we have booted we can re-enable it.
8. execute the install process
```
sudo nixos-install --flake .#nixos
```
Reboot. You are done.