{
description = "Rather safe software that will often need updates";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
 };
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
   vesktop
   easyeffects
#   wineWowPackages.stable
   mangohud
   obsidian
   git
   gitkraken
   gedit
   gparted
   btrfs-progs
   unzip
   nextcloud-client
   nextcloud-talk-desktop
#   lutris
    ];

  programs = {
  steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  
  gamemode.enable = true;
  coolercontrol.enable = true;
  coolercontrol.nvidiaSupport = true;
 
  };
  };
 };
}

