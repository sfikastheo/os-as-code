{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      mac-app-util,
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
            if system == "aarch64-darwin" then
              [
                mac-app-util.homeManagerModules.default
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
