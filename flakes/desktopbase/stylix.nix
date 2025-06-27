{ config, pkgs, ... }:

{
  ## STYLIX THEMING
  stylix.enable = true;
  stylix.autoEnable = true; # Automatically enables most of the below targets
  stylix.polarity = "dark";
  stylix.image = ./SakuratreeLarge.png;

  # Set opacities
  stylix.opacity = {
    terminal = 0.5;
    applications = 0.5;
    desktop = 0.5;
    popups = 0.5;
  };

  # Configure fonts
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };
  
  # Configure cursor
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Explicitly enable GTK and Qt targets if autoEnable isn't sufficient
  stylix.targets.gtk.enable = true;
  stylix.targets.qt.enable = true;
}