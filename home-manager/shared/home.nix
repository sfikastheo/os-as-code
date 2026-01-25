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
    unzip
    xz
    zip
    zstd

    # CLI utils
    bat
    devcontainer
    fd
    gh
    jq
    ripgrep
    sshpass
    television
    wget

    # Terminal
    helix
    neovim
    pre-commit
    vim-full

    # Tops
    btop
    ctop
    iftop

    # Lang Tools
    black
    bun
    cargo
    clang-tools
    clippy
    gcc
    gdb
    go
    gopls
    isort
    lldb
    lua-language-server
    nil
    nixfmt-classic
    nodejs_24
    prettierd
    pyright
    python314
    ruff
    rust-analyzer
    rustc
    rustfmt
    taplo
    typescript-language-server
    uv
    zig
    zls

    # Networking
    nmap
    socat

    # Basics
    file
    gawk
    gnupg
    gnused
    gnutar
    which

    # AI
    claude-code
    codex
    gemini-cli
  ];
}
