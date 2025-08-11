{ pkgs, config, ... }:{

#Mount Harddrives
##Create Mountpoints
  systemd.tmpfiles.rules = [
    "d /mnt/4TBintSSD 0755 daniel users -"
    "d /mnt/4TBextHDD 0755 daniel users -"
  ];
##Mount Drives
  fileSystems."/mnt/4TBintSSD" = {
    device = "/dev/disk/by-uuid/e6dd2647-92ea-4976-ab5a-cfafd71d6b99"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd"];
  };
  fileSystems."/mnt/4TBextHDD" = {
    device = "/dev/disk/by-uuid/e03094ed-812d-4ae3-87c4-b8d7481c2a49"; # Replace with your actual UUID
    fsType = "btrfs";
    options = [ "defaults" "compress=zstd" "nofail"];
  };
}
