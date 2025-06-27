{
description = "Very basic system packages";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
};
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {

hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
services.pipewire.enable = true;
services.pipewire.pulse.enable = true;
services.fstrim.enable = true;
boot.kernelModules = [ "coretemp" "nct6775" ]; #needed for lm-sensors  
};
};
}