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
	
	
#	kdePackages.kwallet
#	kdePackages.kwalletmanager
	seahorse
#	qttools
];

smartd = { #SMART monitoring for harddrives
      enable =
        if profile == "vm"
        then false
        else true;
      autodetect = true;
    };
    
gnome.gnome-keyring.enable = true;
security.pam.services.login.enableGnomeKeyring = true;
security.pam.services.greetd.enableGnomeKeyring = true;
services.gnome.gnome-keyring.enable = true;


hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
services.pipewire.enable = true;
services.pipewire.pulse.enable = true;
services.fstrim.enable = true;
boot.kernelModules = [ "coretemp" "nct6775" ]; #needed for lm-sensors  
};
};
}
