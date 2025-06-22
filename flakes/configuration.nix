# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];
  #Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.efiSysMountPoint = "/boot"; 
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
 # boot.loader.grub.theme = pkgs.nixos-grub2-theme;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daniel = {
    isNormalUser = true;
    description = "daniel";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "daniel";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

# ENABLE FLAKES
nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # THEMING
#stylix.enable = true;
#stylix.targets.gtk.enable = true;
#stylix.targets.qt.enable = true;
#stylix.autoEnable = true;
#stylix.cursor.package = pkgs.bibata-cursors;
#stylix.cursor.name = "Bibata-Modern-Ice";
#stylix.cursor.size = 24;
#stylix.polarity = "dark";
#stylix.image = ./Assets/Wallpapers/SakuratreeLarge.png;
#stylix.opacity.terminal = 0.5;
#stylix.opacity.applications = 0.5;
#stylix.opacity.desktop = 0.5;
#stylix.opacity.popups = 0.5;
#stylix.fonts = {
#	monospace = {
#		package = pkgs.nerd-fonts.jetbrains-mono;
#		name = "JetBrainsMono Nerd Font Mono";
#		};
		
#	sansSerif = {
#		package = pkgs.dejavu_fonts;
#		name = "DejaVu Sans";
#		};
#	serif = {
#		package = pkgs.dejavu_fonts;
#		name = "DejaVu Serif";
#		};
#	};
#}
