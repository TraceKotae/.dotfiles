{
  description = "Toplevel Flake";

  inputs = {
    # Use the unstable channel for both nixpkgs and disko for latest fixes
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko/master"; # Point to disko's master branch
    disko.inputs.nixpkgs.follows = "nixpkgs"; # Ensure disko uses this unstable nixpkgs
  };

  outputs = { self, nixpkgs, disko, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix
          disko.nixosModules.disko
        ];
      };
    };

    # Expose the disko configuration directly for use with 'nix run'
    diskoConfig = disko.lib.diskoConfig {
      modules = [
        ./disks.nix
      ];
    };
  };
}