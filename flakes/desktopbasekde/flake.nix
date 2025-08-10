{
  description = "KDE Base Desktop Configuration";

  outputs = { self, nixpkgs,... }: {
    nixosModules.default = { config, pkgs,... }: {
      imports = [
       ./fonts.nix
       ./thunar.nix
       ./stylix.nix
      ];

      # Enable the X server, required by SDDM and some KDE components [1]
      services.xserver.enable = true;

      # Enable KDE Plasma 6 and SDDM [2]
      services.desktopManager.plasma6.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true; # Run SDDM itself in a Wayland session
      };

      # Enable the correct XDG Desktop Portal for KDE
      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-kde ];
      };

      # Set environment variables for Wayland
      environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

      # Recommended packages for a full KDE experience [2]
      environment.systemPackages = with pkgs; [
        kdePackages.dolphin
        kdePackages.qtsvg # For icons that may be missing
        kdePackages.kio-fuse # For mounting remote locations
        kdePackages.kio-extras # More protocols for kio-fuse
        kdePackages.ksystemlog
        kdePackages.haruna
        kdePackages.kcalc
      ];
    };
  };
}
