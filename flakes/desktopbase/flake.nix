{
description = "Wayland Base Desktop Configuration";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
 baseapps.url = "path:./baseapps";
};
outputs = { self, nixpkgs, baseapps, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
   kitty
   alacritty   
   rofi-wayland
   swww
  ];
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};
 xdg.portal.enable = true;
 xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 environment.sessionVariables = {NIXOS_OZONE_WL = "1"; };
};
 nixosConfigurations = {
   modules = [
    baseapps.nixosModules.default
    ];
   };
  };
};

}