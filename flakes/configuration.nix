# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:{ # Add 'disko' to the parameters if it's not there, like `{ config, pkgs, lib, disko, ... }`
                              # Though usually not needed if disko is in inputs

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
  # i18n.defaultLocale = "en_US.UTF-8";
  # console.font = "lat2-16";
  # console.keyMap = "de";

  # Define your user.
  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  # services.getty.autologinUser = "daniel";

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
  #   };

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
  # in the NixOS manual.
  system.stateVersion = "23.11"; # Did you update this? Using 25.05 now.

  # Directly define disko.devices here,
  # copying the content from your disks.nix (the latest corrected version).
  # This makes the disk configuration part of your main system config.
  disko.devices = {
    disk = {
      nvme1n1 = { # Ensure this is your correct disk (e.g., nvme0n1 or sda)
        type = "disk";
        device = "/dev/nvme1n1"; # Ensure this is your correct device path
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              label = "root";
              content = {
                type = "btrfs";
                extraArgs = ["-L" "nixos" "-f"];
                mountpoint = "/"; # Mount the root Btrfs partition itself at /
                subvolumes = {
                  # This subvolume will hold the actual root filesystem, mounted at `/`
                  "/rootfs" = {
                    mountpoint = "/"; # This subvolume maps to the system's root
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/var/log" = { # Subvolume name matching mountpoint for clarity
                    mountpoint = "/var/log";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  # Subvolume for the swapfile, mounted at a hidden path
                  "/swap" = {
                    mountpoint = "/.swapvol"; # Mountpoint for the subvolume
                    swap.swapfile.size = "10G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };

}