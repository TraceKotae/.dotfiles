{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland"; # Command to execute Hyprland
        user = "daniel"; # Replace with your actual username
      };
    };
  };
}