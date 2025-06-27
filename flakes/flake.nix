{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Add disko as an input
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs"; # Ensure disko uses the same nixpkgs version
  };

  outputs = { self, nixpkgs, disko, ... } @ inputs: { # Add disko to outputs
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix
          disko.nixosModules.disko # Import the disko NixOS module
        ];
      };
    };
  };
}