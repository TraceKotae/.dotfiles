{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Keep unstable for this test
    disko.url = "github:nix-community/disko/master";     # Keep master for this test
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix # ADD THIS LINE BACK IN
          disko.nixosModules.disko
        ];
      };
    };

    # THIS ENTIRE diskoConfig BLOCK SHOULD STILL BE REMOVED:
    # diskoConfig = disko.lib.diskoConfig {
    #   modules = [
    #     ./disks.nix
    #   ];
    # };
  };
}