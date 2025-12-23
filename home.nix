{ pkgs, user, userdir, ... }:

{
  home.username = "${user}";
  home.homeDirectory = "${userdir}";
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  imports = [ ./config ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Archives
    xz
    zip
    zstd
    unzip

    # CLI utils
    fd
    jq
    wget
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

    # Basics
    file
    gawk
    which
    gnused
    gnutar

    # MacOs
    maccy
    rectangle
    iproute2mac

    # Ai
    codex
    gemini-cli
    claude-code
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
