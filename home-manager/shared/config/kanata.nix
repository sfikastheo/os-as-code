{ pkgs, ... }:

let
  kanataConfig = import ./kanata-config.nix { inherit pkgs; };
in
{
  xdg.configFile."kanata/kanata.kbd".text = kanataConfig;
}
