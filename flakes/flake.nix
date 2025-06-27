{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko/master";
	home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
	stylix.url = "github:nix-community/stylix/master";
    disko.inputs.nixpkgs.follows = "nixpkgs";
	nvidia.url = "path:./nvidia";
	systembase.url = "path:./systembase";
  };

  outputs = { self, nixpkgs, disko, nvidia, systembase, home-manager, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix
          disko.nixosModules.disko
		  nvidia.nixosModules.default
		  systembase.nixosModules.default
		  home-manager.nixosModules.home-manager {
          home-manager.users.daniel = import ./home.nix;
          }
        ];
      };
    };
  };
}