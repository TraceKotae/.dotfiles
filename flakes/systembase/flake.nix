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
    device = "/dev/disk/by-uuid/86f159de-d249-492d-bc11-7ec0be37f2b8"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" ];
  };

  fileSystems."/mnt/4TBextHDD" = {
    device = "/dev/disk/by-uuid/82ee1fc8-549b-4cb5-a60b-ceab8aa73edd"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd" ];
  };
};
};
}

