{
description = "Rather safe software that will often need updates";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
 };
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
   discord
   easyeffects
   wineWowPackages.stable
   mangohud
   obsidian
   git
   brave
   alacritty
   kitty
   ];
  #install flatpak
  services.flatpak.enable = true;
  #install steam
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  programs.coolercontrol.enable = true;
  programs.coolercontrol.nvidiaSupport = true;
  };
 };
}

