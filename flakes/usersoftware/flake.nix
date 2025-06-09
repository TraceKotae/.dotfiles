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
   gitkraken
   gedit
   ];
  programs = {
  steam.enable = true;
  gamemode.enable = true;
  coolercontrol.enable = true;
  coolercontrol.nvidiaSupport = true;
  };
  };
 };
}

