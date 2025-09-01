{ config, pkgs, lib, ... }:

{
services.xserver.videoDrivers = ["nvidia"];
hardware.nvidia.modesetting.enable = true;
hardware.nvidia.open = false;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
hardware.nvidia.powerManagement.finegrained = true;
hardware.nvidia.powerManagement.enable = true;
hardware.nvidia.nvidiaSettings = true;
hardware.graphics.enable = true;
#environment.sessionVariables = {
#  __GL_SHADER_DISK_CACHE = "1";
#  __GL_SHADER_DISK_CACHE_PATH = "/mnt/4TBintSSD/NvidiaShaderCache";
#  __GL_SHADER_DISK_CACHE_SIZE = "40073741824";
#}
}
