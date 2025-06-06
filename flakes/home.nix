{ config, pkgs, lib, ... }:
{
 home.stateVersion = "25.05";
 home.username = "daniel";
 home.homeDirectory = "/home/daniel";
 home.packages = with pkgs; [ 
  brave
];
 home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/hyprland.conf;
 home.file.".config/hypr/Autostart".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Autostart.conf;
 home.file.".config/hypr/Design.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Design.conf;
 home.file.".config/hypr/Environment.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Environment.conf;
 home.file.".config/hypr/Input.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Input.conf;
 home.file.".config/hypr/Keybinds.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Keybinds.conf;
 home.file.".config/hypr/Monitors.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Monitors.conf;
 home.file.".config/hypr/Permissions.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Permissions.conf;
 home.file.".config/hypr/Workspaces.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Workspaces.conf;

# home.file.".config/hypr/start.sh".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/start.sh;
}
