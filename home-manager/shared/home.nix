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

    # AI
    codex
    gemini-cli
    claude-code
  ];
}
