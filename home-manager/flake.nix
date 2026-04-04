{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      cfg =
        system: user:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./${user} ];
        };
    in
    {
      homeConfigurations = {
        sfikastheo = cfg "aarch64-darwin" "sfikastheo";
        wsuser-arm = cfg "aarch64-linux" "wsuser";
        wsuser-x86 = cfg "x86_64-linux" "wsuser";
      };
    };
}
