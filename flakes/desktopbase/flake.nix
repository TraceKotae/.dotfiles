{
description = "Wayland Base Desktop Configuration";

outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
 imports = [
    ./fonts.nix
    ./thunar.nix
    ./greetd.nix
	./stylix.nix
	];
  environment.systemPackages = with pkgs; [
   hypridle
   swww
   cliphist
   brightnessctl
   swaynotificationcenter
   kdePackages.dolphin
   kdePackages.qtsvg #icons if missing
   kdePackages.kio-fuse #for mounting remote locations
   kdePackages.kio-extras #more protocols for kio-fuse
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
