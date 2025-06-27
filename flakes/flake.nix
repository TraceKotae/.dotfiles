{
  description = "Toplevel Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
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