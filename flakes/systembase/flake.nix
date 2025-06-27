{
description = "Very basic system packages";

inputs = {
 nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
};
outputs = { self, nixpkgs, ... }: {
 nixosModules.default = { config, pkgs, ... }: {
 imports = [
 ./mountdisks.nix
 ./flatpak.nix
 ./boot.nix
];

environment.systemPackages = with pkgs; [
	wget
	blueman
	pavucontrol
	wireplumber
	appimage-run
	lm_sensors
	unzip
#	kdePackages.kwallet #moved to home.nix
];

hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
services.pipewire.enable = true;
services.pipewire.pulse.enable = true;
services.fstrim.enable = true;
boot.kernelModules = [ "coretemp" "nct6775" ]; #needed for lm-sensors  
};
};
}