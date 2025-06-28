{
description = "Nvidia Drivers";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
};
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
   
];
services.xserver.videoDrivers = ["nvidia"];
hardware.nvidia.modesetting.enable = true;
hardware.nvidia.open = true;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
hardware.nvidia.nvidiaSettings = true;
hardware.graphics.enable = true;

environment.sessionVariables = {
  __GL_SHADER_DISK_CACHE = "1";
  __GL_SHADER_DISK_CACHE_PATH = "/mnt/4TBintSSD/NvidiaShaderCache";
  __GL_SHADER_DISK_CACHE_SIZE = "40073741824";
};
};
};
}

