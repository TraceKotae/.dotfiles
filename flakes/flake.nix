{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko/master";
    disko.inputs.nixpkgs.follows = "nixpkgs";
	home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, home-manager, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix
          disko.nixosModules.disko
		  home-manager.nixosModules.home-manager {
          home-manager.users.daniel = import ./homemanager/home.nix;
		  }
        ];
    };
  };

#Mount Harddrives
##Create Mountpoints
  systemd.tmpfiles.rules = [
    "d /mnt/4TBintSSD 0755 daniel users -"
    "d /mnt/4TBextHDD 0755 daniel users -"
  ];
##Mount Drives
  fileSystems."/mnt/4TBintSSD" = {
    device = "/dev/disk/by-uuid/9d8cbd20-6618-4034-a628-f6cc969b4aa9"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd"];
  };
  fileSystems."/mnt/4TBextHDD" = {
    device = "/dev/disk/by-uuid/8958f43b-79a9-48cb-9ca3-38d7cb586c67"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd" ];
  };

#Nvidia Graphics Drivers
 services.xserver.videoDrivers = ["nvidia"];
 hardware.nvidia.modesetting.enable = true;
 hardware.nvidia.open = true;
 hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
 hardware.nvidia.nvidiaSettings = true;
 hardware.graphics.enable = true;

 environment.sessionVariables = {
   __GL_SHADER_DISK_CACHE = "1";
   __GL_SHADER_DISK_CACHE_PATH = "/mnt/4TBintSSD/NvidiaShaderCache";
   __GL_SHADER_DISK_CACHE_SIZE = "40073741824";
 };
 
#Needed Hardware Settings
 hardware.bluetooth.enable = true;
 hardware.bluetooth.powerOnBoot = true;
 services.pipewire = {
  enable = true;
  pulse.enable = true; };
 services.fstrim.enable = true;
 boot.kernelModules = [ "coretemp" "nct6775" ]; #needed for lm-sensors  


#Extra boot options
 boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = true;
  };
 
#Install System Packages
   environment.systemPackages = with pkgs; [
##Hyprland Related
   hypridle
   swww
   cliphist
   brightnessctl
   swaynotificationcenter
   kdePackages.dolphin
   kdePackages.qtsvg #icons if missing
   kdePackages.kio-fuse #for mounting remote locations
   kdePackages.kio-extras #more protocols for kio-fuse
   ffmpegthumbnailer
##Fonts
   noto-fonts-emoji
   noto-fonts-cjk-sans
   font-awesome
   symbola
   material-icons
   fira-code
   fira-code-symbols
##Basic Packages
   wget
   blueman
   pavucontrol
   wireplumber
   appimage-run
   lm_sensors
   unzip
   kdePackages.kwallet
##UserLevel Packages
   vesktop
   easyeffects
   #wineWowPackages.stable
   mangohud
   obsidian
   git
   gitkraken
   gedit
   gparted
   btrfs-progs
   unzip
   nextcloud-client
 ];
  
#Enable System Packages & Configure them
##Hyprland
   programs.hyprland = {
    enable = true;
    xwayland.enable = true;
     };
   xdg.portal.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
   xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];
   xdg.portal.configPackages = [pkgs.hyprland];
   environment.sessionVariables = {NIXOS_OZONE_WL = "1"; };
##Flatpak Support
   services.flatpak.enable = true;
   systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
   };
##Greetd
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland"; # Command to execute Hyprland
        user = "daniel"; # Replace with your actual username
      };
    };
  };
##Thunar
   programs = {
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
   };
   services.gvfs.enable = true; # Mount, trash, and other functionalities
   services.tumbler.enable = true; # Thumbnail support for images
##Steam
  steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
##GamingBonusPackages  
  gamemode.enable = true;
  coolercontrol.enable = true;
  coolercontrol.nvidiaSupport = true;
  };
  
#Theming
stylix.enable = true;
stylix.targets.gtk.enable = true;
stylix.targets.qt.enable = true;
stylix.autoEnable = true;
stylix.cursor.package = pkgs.bibata-cursors;
stylix.cursor.name = "Bibata-Modern-Ice";
stylix.cursor.size = 24;
stylix.polarity = "dark";
stylix.image = ./Assets/Wallpapers/SakuratreeLarge.png;
stylix.opacity.terminal = 0.5;
stylix.opacity.applications = 0.5;
stylix.opacity.desktop = 0.5;
stylix.opacity.popups = 0.5;
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
}