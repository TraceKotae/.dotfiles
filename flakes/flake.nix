{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Still using unstable for diagnosis
    disko.url = "github:nix-community/disko/master";     # Still using master for diagnosis
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          # REMOVE THIS LINE IF IT EXISTS: ./disks.nix
          disko.nixosModules.disko # Keep this to enable the disko module
        ];
      };
    };

    # REMOVE THIS ENTIRE diskoConfig BLOCK:
    # diskoConfig = disko.lib.diskoConfig {
    #   modules = [
    #     ./disks.nix
    #   ];
    # };
  };
}