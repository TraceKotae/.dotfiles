{ pkgs, config, ... }:{

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
}