{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    clock24 = true;
    focusEvents = true;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-b";
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = yank;
        extraConfig = ''
          set -g @yank_action 'copy-pipe'
          set -g @yank_selection_mouse 'clipboard'
          set -g @yank_with_mouse on
        '';
      }
      resurrect
    ];

    extraConfig = ''
      # general Settings
      set -ga terminal-features "xterm-256color:RGB"
      set -g allow-passthrough on
      set -g set-clipboard on

      set -g monitor-bell off
      set -g status-bg black
      set -g status-fg white
      set -g status-position top

      # scratch session
      bind t display-popup -E \
        -w 90% -h 90% \
        -d "#{pane_current_path}" \
        tmux new-session -A -s scratch

      # colemak-DH motions for pane navigation
      unbind h
      unbind j
      unbind k
      unbind l
      unbind v

      bind m select-pane -L
      bind n select-pane -D
      bind e select-pane -U
      bind i select-pane -R

      bind u split-window -h
      bind l split-window -v
      bind k next-window

      # copy mode
      bind v copy-mode
      bind -T copy-mode-vi q send -X cancel
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi V send -X select-line
      bind -T copy-mode-vi C-v send -X rectangle-toggle

      # unbind existing motions
      unbind -T copy-mode-vi h
      unbind -T copy-mode-vi j
      unbind -T copy-mode-vi k
      unbind -T copy-mode-vi K
      unbind -T copy-mode-vi l
      unbind -T copy-mode-vi L
      unbind -T copy-mode-vi e
      unbind -T copy-mode-vi i
      unbind -T copy-mode-vi m
      unbind -T copy-mode-vi n

      # colemak motion mappings
      bind -T copy-mode-vi k send -X search-again
      bind -T copy-mode-vi K send -X search-reverse
      bind -T copy-mode-vi m send -X cursor-left
      bind -T copy-mode-vi n send -X cursor-down
      bind -T copy-mode-vi e send -X cursor-up
      bind -T copy-mode-vi i send -X cursor-right
      bind -T copy-mode-vi l send -X next-word-end
      bind -T copy-mode-vi L send -X next-space-end
      bind -T copy-mode-vi C-n send -X halfpage-down
      bind -T copy-mode-vi C-e send -X halfpage-up
    '';
  };
}
