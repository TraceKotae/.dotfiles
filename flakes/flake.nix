{
description = "Toplevel Flake";

inputs = {
nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
stylix.url = "github:nix-community/stylix/release-25.05";
desktopbase.url = "path:./desktopbase";
systembase.url = "path:./systembase";
nvidia.url = "path:./nvidia";
home-manager.url = "github:nix-community/home-manager/release-25.05";
home-manager.inputs.nixpkgs.follows = "nixpkgs";
usersoftware.url = "path:./usersoftware";
};

outputs = { self, nixpkgs, desktopbase, systembase, home-manager, nvidia, usersoftware, stylix, ... } @ inputs: {
 nixosConfigurations = {
  "nixos" = nixpkgs.lib.nixosSystem {
   system = "x86_64-linux";
   modules = [
    ./configuration.nix
    stylix.nixosModules.stylix
    desktopbase.nixosModules.default
    systembase.nixosModules.default
    nvidia.nixosModules.default
    usersoftware.nixosModules.default
    home-manager.nixosModules.home-manager {
    home-manager.users.daniel = import ./home.nix;
     }
    ];
   };
  };
 };
}
