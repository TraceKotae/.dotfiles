{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Keep unstable for this test
    disko.url = "github:nix-community/disko/master";     # Keep master for this test
    disko.inputs.nixpkgs.follows = "nixpkgs";
	nvidia.url = "path:./nvidia";
  };

  outputs = { self, nixpkgs, disko, nvidia, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix
          disko.nixosModules.disko
		  nvidia.nixosModules.default
        ];
      };
    };
  };
}