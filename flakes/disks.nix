{
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
                  "/var/log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
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
Step 3: Update your flake.nix
This step brings back the import of disks.nix into your system configuration, but crucially, it still does not define the diskoConfig output.

Nix

{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Keep unstable for this test
    disko.url = "github:nix-community/disko/master";     # Keep master for this test
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix # ADD THIS LINE BACK IN
          disko.nixosModules.disko
        ];
      };
    };

    # THIS ENTIRE diskoConfig BLOCK SHOULD STILL BE REMOVED:
    # diskoConfig = disko.lib.diskoConfig {
    #   modules = [
    #     ./disks.nix
    #   ];
    # };
  };
}