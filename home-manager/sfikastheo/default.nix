{ pkgs, ... }:

{
  home = {
    username = "sfikastheo";
    homeDirectory = "/Users/sfikastheo";
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

  # Import shared configuration
  imports = [ ../shared/home.nix ];

  home.packages = with pkgs; [
    # Utils
    iproute2mac
    kanata

    # Applications
    #firefox
    #podman-desktop
    #alacritty
    maccy
    rectangle
    #signal-desktop
    #spotify

    # Work
    #_1password-gui
    #slack
    #mongodb-compass
    #zoom-us

    # Fonts
    nerd-fonts.geist-mono
  ];

  fonts.fontconfig.enable = true;
}
