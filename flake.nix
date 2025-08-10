{
  description = "Toplevel Flake";

    inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    stylix.url = "github:nix-community/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, stylix, ... } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./nvidia.nix
          ./boot.nix
          ./flatpak.nix
          ./packages.nix
          stylix.nixosModules.stylix
          ./stylix.nix
        ];
      };
    };
  };
}
