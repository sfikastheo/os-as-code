{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "$HOME/.config";
    PNPM_HOME = "$HOME/.pnpm";
  };

  home.sessionPath = [
    "$HOME/.pnpm"
    "$HOME/.bun/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];

  home.file.".npmrc".text = ''
    store-dir=${config.home.homeDirectory}/.pnpm/store
    global-bin-dir=${config.home.homeDirectory}/.pnpm
  '';

  imports = [ ./config ];

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
    graphviz
    helix
    jq
    neovim
    pre-commit
    ripgrep
    sshpass
    television
    tio
    vim-full
    wget

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
    nixfmt
    nodejs_24
    pnpm
    prettierd
    pyright
    python314
    ruff
    rust-analyzer
    rustc
    rustfmt
    taplo
    tree-sitter
    typescript-language-server
    uv
    zig
    zls

    # Networking
    nmap
    socat
    tcpdump

    # Basics
    file
    gawk
    gnupg
    gnused
    gnutar
    openssl
    pkg-config
    which

    # Work
    _1password-cli
    awscli2
    cachix
    cloudflared
    mongosh
    protobuf
    ssm-session-manager-plugin
    teleport_17
    gst_all_1.gst-devtools
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer
  ];
}
