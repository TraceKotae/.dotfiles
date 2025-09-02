{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    nano
    wget
    brave
    vesktop
    easyeffects
    mangohud
    obsidian
    git
    git-lfs
    gitkraken
    gedit
    gparted
    btrfs-progs
    unzip
    nextcloud-client
    nextcloud-talk-desktop
    spotify
    libreoffice
    vlc
    #tailscale
	blueman
	pavucontrol
	wireplumber
	appimage-run
	lm_sensors
	remmina
  ];

    nixpkgs.overlays = [
    (self: super: {
    tailscale = super.tailscale.overrideAttrs (oldAttrs: {
        # This disables the "check" phase, which runs the tests
        doCheck = false;
      });
    })
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
 services.tailscale.enable = true;
}
