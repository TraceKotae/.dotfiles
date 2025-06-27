{
  disko.devices = {
    disk = {
      nvme1n1 = { # Ensure this is your correct disk
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
                mountOptions = [ "umask=0077" ]; # Changed to common umask for ESP
              };
            };
            root = {
              size = "100%";
              label = "root";
              content = {
                type = "btrfs"; # Changed from type="filesystem"; format="btrfs";
                extraArgs = ["-L" "nixos" "-f"];
                mountpoint = "/"; # Mount the root Btrfs partition here
                subvolumes = {
                  # This subvolume will hold the root filesystem, mounted at `/`
                  # The common convention for this subvolume is `@` or `rootfs`
                  "/rootfs" = {
                    mountpoint = "/";
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
                  "/var/log" = { # Changed subvolume name for clarity
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