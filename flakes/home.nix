{ config, pkgs, lib, host, ... }:

{
  home.stateVersion = "25.11";
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.packages = with pkgs; [
  kdePackages.kwallet-pam
  ];
  
  #services.kwalletd.enable = true;

  programs.brave.enable = true;
  
  programs.kitty.enable = true;
  programs.kitty.settings.confirm_os_window_close = 0;
  
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
  home.file.".config/hypr/UserConfigs/WindowRules.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/WindowRules.conf;
  
imports = [
	./homemanager/gtk.nix
	./homemanager/qt.nix
	./homemanager/swappy.nix
    ./homemanager/swaync.nix
	./homemanager/waybar.nix
	./homemanager/hypridle.nix
	./homemanager/hyprlock.nix
    ./Assets/wlogout/default.nix
  ];

#Set Default Terminal to Kitty
##Thunar
      xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
      TerminalEmulatorDismissed=true
    '';
##Dolphin
        xdg.configFile."kdeglobals".source = pkgs.writeText "kdeglobals" ''
    [General]
    TerminalApplication=kitty
  '';
}
