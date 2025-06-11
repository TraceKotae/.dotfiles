{ config, pkgs, ... }:

{
  # Enable Wayland support
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  environment.variables.NIXOS_OZONE_WL = "1"; # Optional: Hint Electron apps to use Wayland

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Enable Greetd
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland"; # Command to execute Hyprland
        user = "YOUR_USERNAME"; # Replace with your actual username
      };
      # Optional: default_session if you want a greeter after logout
      # default_session = {
      #   command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # Example: tuigreet with Hyprland session option
      #   user = "greeter"; # Or any user you want greetd to run as (can be non-existent)
      # };
    };
  };

  # You might also want to set your default shell if it's not bash,
  # and ensure your shell is properly configured for Wayland sessions.
  # For example, if you use zsh:
  # programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;

  # Essential components for Hyprland (often already enabled by programs.hyprland.enable)
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ]; # Or pkgs.xdg-desktop-portal-gtk
}
