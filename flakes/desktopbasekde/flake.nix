{
description = "KDE Base Desktop Configuration";

outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
 imports = [
    ./fonts.nix
    ./thunar.nix
    ./stylix.nix
	];
  environment.systemPackages = with pkgs; [
   kdePackages.dolphin
   kdePackages.qtsvg #icons if missing
   kdePackages.kio-fuse #for mounting remote locations
   kdePackages.kio-extras #more protocols for kio-fuse
  ];
 services.xserver.enable = true;
 services.desktopManager.plasma6.enable = true;
 services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Run SDDM itself in a Wayland session
  };
};
 xdg.portal.enable = true;
 xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];
 environment.sessionVariables = {NIXOS_OZONE_WL = "1"; };
};
};
}
