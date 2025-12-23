{ config, pkgs, ... }:

{
  home.username = "sfikastheo";
  home.homeDirectory = "/Users/sfikastheo";

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  imports = [ ./shell.nix ];

  home.packages = with pkgs; [
    # Archives
    xz
    zip
    zstd
    unzip

    # CLI utils
    fd
    jq
    git
    wget
    delta
    git-lfs
    sshpass
    ripgrep
    television

    # Terminal
    tmux
    btop
    helix
    neovim
    vim-full
    pre-commit

    # Tops
    ctop
    btop
    iftop

    # Lang Tools
    go
    uv
    nil
    gdb
    gcc
    zig
    zls
    bun
    lldb
    ruff
    gopls
    isort
    taplo
    rustc
    cargo
    black
    clippy
    pyright
    rustfmt
    prettierd
    python314
    nodejs_24
    clang-tools
    rust-analyzer
    nixfmt-classic
    lua-language-server
    typescript-language-server

    # Networking
    nmap
    socat
    iproute2mac

    # Basics
    file
    gawk
    which
    gnused
    gnutar
  ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
