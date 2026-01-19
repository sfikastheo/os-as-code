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
    ethtool
    lm_sensors
    lsof
    ltrace
    pciutils
    strace
    sysstat
    usbutils

    # Containers
    dive
    fuse-overlayfs
    podman
    podman-compose
    runc

    # Applications
    alacritty
    discord
    firefox
    foliate
    podman-desktop
    signal-desktop
    tor-browser
    unstable.zed-editor

    # Work
    _1password-cli
    _1password-gui
    awscli2
    cachix
    cloudflared
    efitools
    mongodb-compass
    mongosh
    picocom
    sbsigntool
    slack
    ssm-session-manager-plugin
    teleport_17
    zoom-us

    # Fonts
    nerd-fonts.geist-mono
  ];
}
