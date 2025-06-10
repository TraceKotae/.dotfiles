{ config, pkgs, lib, ... }:
{
 home.stateVersion = "25.05";
 home.username = "daniel";
 home.homeDirectory = "/home/daniel";
 home.packages = with pkgs; [ 
  brave
#  rofi-wayland
];
programs.kitty.enable = true;
programs.rofi.enable = true;
 home.file.".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/hyprland.conf;
 home.file.".config/hypr/UserConfigs/Autostart.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Autostart.conf;
 home.file.".config/hypr/UserConfigs/Design.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Design.conf;
 home.file.".config/hypr/UserConfigs/Environment.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Environment.conf;
 home.file.".config/hypr/UserConfigs/Input.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Input.conf;
 home.file.".config/hypr/UserConfigs/Keybinds.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Keybinds.conf;
 home.file.".config/hypr/UserConfigs/Monitors.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Monitors.conf;
 home.file.".config/hypr/UserConfigs/Permissions.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Permissions.conf;
 home.file.".config/hypr/UserConfigs/Workspaces.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/Workspaces.conf;
 home.file.".config/hypr/initialstart.sh".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/initialstart.sh;
 #home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/kitty/kitty.conf;
 #home.file.".config/kitty/kitty-themes/Japanesque.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/kitty/kitty-themes/Japanesque.conf;
# home.file.".config/hypr/start.sh".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/start.sh;

}
