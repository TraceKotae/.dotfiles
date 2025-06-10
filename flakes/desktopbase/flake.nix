{
description = "Wayland Base Desktop Configuration";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
};
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
 imports = [
    ./boot.nix
	./flatpak.nix
	./fonts.nix
	./fastfetch.nix
	];
  environment.systemPackages = with pkgs; [
   kitty
   alacritty   
   rofi-wayland
   swww
   cliphist
   brightnessctl
  ];
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};
 xdg.portal.enable = true;
 xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 environment.sessionVariables = {NIXOS_OZONE_WL = "1"; };
};
};
}
