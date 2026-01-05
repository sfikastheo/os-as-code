{ pkgs, ... }:

{
  home = {
    sessionVariables = {
      LANG = "en_US.UTF-8";
    };

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

  # Import shared configuration
  imports = [ ../shared/home.nix ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # Basics
    ldns
    openssh
    openssl

    # System tools
    lsof
    strace
    ltrace
    sysstat
    ethtool
    pciutils
    usbutils
    lm_sensors

    # Containers
    runc
    dive
    podman
    podman-compose
    fuse-overlayfs

    # Applications
    firefox
    foliate
    discord
    alacritty
    tor-browser
    signal-desktop
    podman-desktop
    unstable.zed-editor

    # Work
    slack
    cachix
    zoom-us
    awscli2
    picocom
    mongosh
    efitools
    sbsigntool
    cloudflared
    teleport_17
    _1password-gui
    _1password-cli
    mongodb-compass
    ssm-session-manager-plugin

    # Fonts
    nerd-fonts.geist-mono
  ];
}
