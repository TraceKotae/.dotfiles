{
  description = "Toplevel Flake";

    inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nvidia.url = "path:./nvidia";
    nvidia.inputs.nixpkgs.follows = "nixpkgs";

    systembase.url = "path:./systembase";
    systembase.inputs.nixpkgs.follows = "nixpkgs";

    desktopbase.url = "path:./desktopbase";
    desktopbase.inputs.nixpkgs.follows = "nixpkgs";
    
    desktopbasekde.url = "path:./desktopbasekde";
    desktopbasekde.inputs.nixpkgs.follows = "nixpkgs";

    usersoftware.url ="path:./usersoftware";
    usersoftware.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, nvidia, systembase, home-manager, stylix, desktopbase, desktopbasekde, usersoftware, ... } @ inputs: {
    nixosConfigurations = {
      "nixos-hypr" = nixpkgs.lib.nixosSystem {
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
        "nixos-kde" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./disks.nix
          disko.nixosModules.disko
		  nvidia.nixosModules.default
		  stylix.nixosModules.stylix
		  systembase.nixosModules.default
		  desktopbasekde.nixosModules.default
		  usersoftware.nixosModules.default
		  home-manager.nixosModules.home-manager {
          home-manager.users.daniel = import ./home.nix;
          }
        ];
      };
    };
  };
}
