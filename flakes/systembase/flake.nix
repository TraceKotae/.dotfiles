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
 pulse.enable = true};
services.fstrim.enable = true;
boot.kernelModules = [ "coretemp" "nct6775" ]; #needed for lm-sensors  
};
};
}