{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko/master";
	home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
	stylix.url = "github:nix-community/stylix/master";
    disko.inputs.nixpkgs.follows = "nixpkgs";
	nvidia.url = "path:./nvidia";
	systembase.url = "path:./systembase";
	desktopbase.url = "path:./desktopbase";
	usersoftware.url ="path:./usersoftware";
  };

  outputs = { self, nixpkgs, disko, nvidia, systembase, home-manager, stylix, desktopbase, usersoftware, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix
          disko.nixosModules.disko
		  nvidia.nixosModules.default
		  stylix.nixosModules.stylix
		  systembase.nixosModules.default
		  desktopbase.nixosModules.default
		  usersoftware.nixosModules.default
		  home-manager.nixosModules.home-manager {
          home-manager.users.daniel = import ./home.nix;
          }
        ];
      };
    };
  };
}