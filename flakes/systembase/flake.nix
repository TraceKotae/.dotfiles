{
description = "Very basic system packages";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
};
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
 imports = [
 ./mountdisks
];
environment.systemPackages = with pkgs [
wget
blueman
pavucontrol
wireplumber
#seahorse
appimage-run
lm_sensors
unzip
kdePackages.kwallet
];
hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
services.pipewire = {
 enable = true;
 pulse.enable = true; };
#services.gnome.gnome-keyring.enable = true;
services.fstrim.enable = true;
boot.kernelModules = [ "coretemp" "nct6775" ]; #needed for lm-sensors  

# Mount Harddrives
# create dirs and assign ownership

  systemd.tmpfiles.rules = [
    "d /mnt/4TBintSSD 0755 daniel users -"
    "d /mnt/4TBextHDD 0755 daniel users -"
  ];
  
   # ... your fileSystems mounts for the Btrfs drives (from previous instructions) ...
  fileSystems."/mnt/4TBintSSD" = {
    device = "/dev/disk/by-uuid/c9fb51d5-39db-4ecf-a688-4c949c5c644b"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" ];
  };

  fileSystems."/mnt/4TBextHDD" = {
    device = "/dev/disk/by-uuid/e5e5d4f1-1a68-4d0c-819f160cdd37005c"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd" ];
  };
};
};
}

