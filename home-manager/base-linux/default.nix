{ pkgs, user, ... }:

{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
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
    # Utils
    efitools
    ethtool
    ldns
    lm_sensors
    lsof
    ltrace
    openssh
    openssl
    pciutils
    qdl
    sbsigntool
    strace
    sysstat
    usbutils

    # Containers
    dive
    fuse-overlayfs
    podman
    podman-compose
    runc

    # AI
    claude-code
    codex
    gemini-cli

    # Fonts
    nerd-fonts.geist-mono
  ];
}
