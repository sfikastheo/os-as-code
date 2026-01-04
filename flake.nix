{
  description = "Nix Development System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
    nixosConfigurations = {
      nds = let
        user = "sfnix";
        userdir = "/home/${user}";
        system = "x86_64-linux";
        specialArgs = { inherit user userdir nixpkgs-unstable; };
      in nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
          ./nixos/framework13
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.${system};
              })
            ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs // specialArgs;
            home-manager.users.${user} = import ./home-manager/${user};
          }
        ];
      };
    };
  };
}
