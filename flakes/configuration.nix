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
   
##THEMING   
stylix.enable = true;
#stylix.targets.gtk.enable = true;
#stylix.targets.qt.enable = true;
stylix.autoEnable = true;
#stylix.cursor.package = pkgs.bibata-cursors;
#stylix.cursor.name = "Bibata-Modern-Ice";
#stylix.cursor.size = 24;
#stylix.polarity = "dark";
stylix.image = ./Assets/Wallpapers/SakuratreeLarge.png;
#stylix.opacity.terminal = 0.5;
#stylix.opacity.applications = 0.5;
#stylix.opacity.desktop = 0.5;
#stylix.opacity.popups = 0.5;
#stylix.fonts = {
#	monospace = {
#		package = pkgs.nerd-fonts.jetbrains-mono;
#		name = "JetBrainsMono Nerd Font Mono";
#		};
#		
#	sansSerif = {
#		package = pkgs.dejavu_fonts;
#		name = "DejaVu Sans";
#		};
#	serif = {
#		package = pkgs.dejavu_fonts;
#		name = "DejaVu Serif";
#		};
#	};
}