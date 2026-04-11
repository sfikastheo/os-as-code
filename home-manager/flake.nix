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
        system: user:
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
          modules = extraModules ++ [ ./${user} ];
        };
    in
    {
      homeConfigurations = {
        m1pro = cfg "aarch64-darwin" "sfikastheo";
        wsuser-arm = cfg "aarch64-linux" "wsuser";
        wsuser-x86 = cfg "x86_64-linux" "wsuser";
      };
    };
}
