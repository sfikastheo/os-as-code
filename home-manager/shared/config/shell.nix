{ config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "emacs";

    history = {
      path = "${config.xdg.configHome}/zsh/history";
      saveNoDups = true;
      append = true;
      share = true;
      size = 20000;
      save = 20000;
    };

    shellAliases = {
      nv = "nvim";
      cdr = "cd $(git rev-parse --show-toplevel)";
      md = "mkdir -p";
      tmux = "tmux -2";
    };

    initContent = ''
      source "$HOME/Projects/secrets/wldrc"
      source "$HOME/Projects/secrets/secrc"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow --no-ignore --glob '.git/*'";
    defaultOptions = [ "--height 40%" "--reverse" ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd to" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
}
