{
  description = "NixOs Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      cfg =
        system: host: profile: user:
        let
          specialArgs = inputs // {
            inherit user;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./nixos/${host}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.${user} = import ./home-manager/${profile};
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        ds1 = cfg "x86_64-linux" "ds1" "base-linux" "wsuser";
      };
    };
}
