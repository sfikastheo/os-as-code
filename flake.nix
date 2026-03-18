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

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      cfg = system: host: user:
        let specialArgs = inputs // { inherit user nixpkgs-unstable; };
        in nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./nixos/${host}
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
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.${user} = import ./home-manager/${user};
            }
          ];
        };
    in {
      nixosConfigurations = {
        fw13 = cfg "x86_64-linux" "nds" "sfnix";
        nuc01 = cfg "x86_64-linux" "ws1" "wsuser";
      };
    };
}
