{ pkgs, ... }:

let
  kanataConfig = import ../shared/kanata.nix { inherit pkgs; };
in
{
  home = {
    username = "theodore.sfikas";
    homeDirectory = "/Users/theodore.sfikas";
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  homebrew.casks = [
    "alacritty"
    "chatgpt"
    "firefox"
    "linear-linear"
    "mongodb-compass"
    "signal"
    "spotify"
    "whatsapp"
    #"steam"
    #"slack"            # MDM
    #"1password"        # MDM
    #"zoom"             # MDM
  ];

  # Import shared configuration
  imports = [ ../shared/home.nix ];

  home.packages = with pkgs; [
    # Utils
    iproute2mac
    kanata

    # Applications
    maccy
    podman
    rectangle

    # Fonts
    nerd-fonts.geist-mono
  ];

  # Setup Kanata
  xdg.configFile."kanata/kanata.kbd".text = kanataConfig;

  fonts.fontconfig.enable = true;
}
