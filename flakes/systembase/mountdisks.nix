{ pkgs, config, ... }:{

#Mount Harddrives
##Create Mountpoints
  systemd.tmpfiles.rules = [
    "d /mnt/4TBintSSD 0755 daniel users -"
    "d /mnt/4TBextHDD 0755 daniel users -"
  ];
##Mount Drives
  fileSystems."/mnt/4TBintSSD" = {
    device = "/dev/disk/by-uuid/d5f7e201-3af5-464f-b401-49d2f83ff6e0"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd"];
  };
  fileSystems."/mnt/4TBextHDD" = {
    device = "/dev/disk/by-uuid/9cde984d-7975-4462-b42b-c75705d0d550"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd" ];
  };
}