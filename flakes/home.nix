{ config, pkgs, lib, ... }:
{
 home.stateVersion = "25.05";
 home.username = "daniel";
 home.homeDirectory = "/home/daniel";
 home.packages = with pkgs; [ 
  brave
];
 home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/hyprland.conf;
# home.file.".config/hypr/start.sh".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/start.sh;
}
