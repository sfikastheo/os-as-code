{ pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  openCommand = if isDarwin then "open" else "xdg-open";
  primaryMods = if isDarwin then "Command" else "Alt";
  fontSize = if isDarwin then "14" else "10";
in {
  xdg.configFile."alacritty/alacritty.toml".text = ''
    [font]
    size = ${fontSize}

    [font.bold]
    family = "GeistMono Nerd Font Mono"
    style = "Bold"

    [font.italic]
    family = "GeistMono Nerd Font Mono"
    style = "Italic"

    [font.normal]
    family = "GeistMono Nerd Font Mono"
    style = "Regular"

    [terminal.shell]
    args = ["-l"]
    program = "zsh"

    [window]
    option_as_alt = "Both"
    padding = { x = 6, y = 0 }
    opacity = 1.0

    [scrolling]
    history = 50000
    multiplier = 3

    [colors]
    line_indicator = { foreground = "#424242", background = "#1e1e1e" }
    footer_bar = { foreground = "#cb775d", background = "#161616" }
    selection = { text = "#cb775d", background = "#424242" }

    [colors.search]
    matches = { foreground = "#101010", background = "#cb775d" }
    focused_match = { foreground = "#101010", background = "#b74e58" }

    [colors.hints]
    start = { foreground = "#161616", background = "#cb775d" }
    end = { foreground = "#161616", background = "#cb775d" }

    [selection]
    semantic_escape_chars = ",│`|:\"' ()[]{}<>\t"
    save_to_clipboard = false

    [[hints.enabled]]
    command = "${openCommand}"
    post_processing = true
    mouse.enabled = true
    hyperlinks = true
    persist = false
    binding = { key = "O", mods = "${primaryMods}" }
    regex = "(ipfs:|ipns:|magnet:|mailto:|gemini://|gopher://|https://|http://|news:|file:|git://|ssh:|ftp://)[^\u0000-\u001F\u007F-\u009F<>\"\\s{-}\\^⟨⟩`\\\\]+"

    [hints]
    alphabet = "ftluresdh"

    [keyboard]
    bindings = [
      { key = "/", mods = "${primaryMods}", action = "SearchForward" },
      { key = "?", mods = "${primaryMods}", action = "SearchBackward" },
      # Vi mode bindings
      { key = "V", mods = "${primaryMods}|Shift", action = "ToggleViMode" },
      { key = "L", mode = "Vi|~Search", action = "WordRightEnd" },
      { key = "K", mode = "Vi|~Search", action = "SearchNext" },
      { key = "K", mods = "Shift", mode = "Vi|~Search", action = "SearchPrevious" },
      { key = "M", mode = "Vi|~Search", action = "Left" },
      { key = "N", mode = "Vi|~Search", action = "Down" },
      { key = "E", mode = "Vi|~Search", action = "Up" },
      { key = "I", mode = "Vi|~Search", action = "Right" },
    ]

    # Default colors
    [colors.primary]
    background = '#181818'
    foreground = '#d8d8d8'

    [colors.cursor]
    text = '#181818'
    cursor = '#d8d8d8'

    # Normal colors
    [colors.normal]
    black   = '#181818'
    red     = '#ab4642'
    green   = '#a1b56c'
    yellow  = '#f7ca88'
    blue    = '#7cafc2'
    magenta = '#ba8baf'
    cyan    = '#86c1b9'
    white   = '#d8d8d8'

    # Bright colors
    [colors.bright]
    black   = '#585858'
    red     = '#ab4642'
    green   = '#a1b56c'
    yellow  = '#f7ca88'
    blue    = '#7cafc2'
    magenta = '#ba8baf'
    cyan    = '#86c1b9'
    white   = '#f8f8f8'
  '';
}
