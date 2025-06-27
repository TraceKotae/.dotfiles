{ config, pkgs, lib, ... }: {

#Bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.initrd.luks.devices = lib.mkForce {};
  
#Define your useraccount
    users.users.daniel = {
    isNormalUser = true;
    description = "daniel";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    packages = with pkgs; [];
    };

#Networking
  networking.hostName = "nixos"; # Define your hostname. This is used for more than just the network!
  networking.networkmanager.enable = true;

#Allow unfree packages
  nixpkgs.config.allowUnfree = true;

#Install these Packages
  environment.systemPackages = with pkgs; [
   git
   ntfs3g #to read ntfs drives this should also make windows efi show up in grub as bootable options.
   ];

}