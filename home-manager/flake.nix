{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew = {
      url = "github:koalalorenzo/home-manager-brew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      homebrew,
      ...
    }:
    let
      cfg =
        system: profile: extraSpecialArgs:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraModules =
            if (system == "aarch64-darwin") then
              [
                homebrew.homeManagerModules.default
              ]
            else
              [ ];
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          inherit extraSpecialArgs;
          modules = extraModules ++ [ ./${profile} ];
        };
    in
    {
      homeConfigurations = {
        m1pro = cfg "aarch64-darwin" "m1-pro" { user = "sfikastheo"; };
        m4max = cfg "aarch64-darwin" "m4-max" { user = "theodore.sfikas"; };
        vps1 = cfg "aarch64-linux" "base-linux" { user = "wsuser"; };
      };
    };
}
