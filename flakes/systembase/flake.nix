{
description = "Very basic system packages";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
};
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
git
wget
blueman
pavucontrol
xfce.thunar   
wireplumber
seahorse
appimage-run
lm_sensors
unzip
];
hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
services.pipewire = {
 enable = true;
 pulse.enable = true; };
services.gnome.gnome-keyring.enable = true;
services.fstrim.enable = true;
boot.kernelModules = [ "coretemp" "nct6775" ]; #needed for lm-sensors  

# Mount Harddrives
#  fileSystems."/mnt/4TBintSSD" = {
#    device = "/dev/disk/by-uuid/ebc9f941-239d-4bfa-8e53-e7e18f786350"; # REPLACE with your actual UUID
#    fsType = "btrfs"; # REPLACE with your filesystem type (e.g., "btrfs", "xfs")
#    options = [
#          "defaults"
#          "nofail"
#          "uid=1000" # Replace with your user's UID
#          "gid=100"  # Replace with your user's GID (usually "users" group)
#          # "compress-force=zstd" # Add other options as needed, e.g., "compress-force=zstd" for btrfs
#        ];
# };
};
};
}

