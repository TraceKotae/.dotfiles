{ config, pkgs, lib, ... }:
{
 home.stateVersion = "25.05";
 home.username = "daniel";
 home.homeDirectory = "/home/daniel";
 home.packages = with pkgs; [ 
  brave
];
 home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/hyprland.conf;
 home.file.".config/hypr/UserConfigs/Autostart".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Autostart.conf;
 home.file.".config/hypr/UserConfigs/Design.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Design.conf;
 home.file.".config/hypr/UserConfigs/Environment.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Environment.conf;
 home.file.".config/hypr/UserConfigs/Input.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Input.conf;
 home.file.".config/hypr/UserConfigs/Keybinds.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Keybinds.conf;
 home.file.".config/hypr/UserConfigs/Monitors.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Monitors.conf;
 home.file.".config/hypr/UserConfigs/Permissions.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Permissions.conf;
 home.file.".config/hypr/UserConfigs/Workspaces.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/UserConfigs/Workspaces.conf;

# home.file.".config/hypr/start.sh".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/start.sh;
}
