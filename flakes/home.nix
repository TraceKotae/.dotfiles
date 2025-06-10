{ config, pkgs, lib, host, ... }:

{
  home.stateVersion = "25.05";
  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.packages = with pkgs; [
  ];

  programs.brave.enable = true;
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
  home.file.".config/hypr/UserConfigs/WindowRules.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/WindowRules.conf;
  #home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/kitty/kitty.conf;
  #home.file.".config/kitty/kitty-themes/Japanesque.conf".source = config.lib.file.mkOutOfStoreSymlink ./Assets/kitty/kitty-themes/Japanesque.conf;
  # home.file.".config/hypr/start.sh".source = config.lib.file.mkOutOfStoreSymlink ./Assets/Hyprland/start.sh;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-center = ["hyprland/workspaces"];
        modules-left = [
          "custom/startmenu"
          "hyprland/window"
          "pulseaudio"
          "cpu"
          "memory"
          "idle_inhibitor"
        ];
        modules-right = [
          "custom/hyprbindings"
          "custom/notification"
          "custom/exit"
          "battery"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "clock" = {
          format = " {:L%H:%M}";
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };

        "hyprland/window" = {
          max-length = 22;
          separate-outputs = false;
          rewrite = {
            "" = " 🙈 No Windows? ";
          };
        };

        "memory" = {
          interval = 5;
          format = " {}%";
          tooltip = true;
        };

        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };

        "disk" = {
          format = " {free}";
          tooltip = true;
        };

        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };

        "tray" = {
          spacing = 12;
        };

        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "sleep 0.1 && pavucontrol";
        };

        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };

        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          on-click = "sleep 0.1 && rofi-launcher";
        };

        "custom/hyprbindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && list-keybinds";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
      }
    ];
  };
}
