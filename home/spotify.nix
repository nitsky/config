{ pkgs, ... }: {
  home.packages = with pkgs; [
    ncspot
  ];
  xdg.configFile."ncspot/config.toml".text = ''
    audio_cache = false
    backend = "pulseaudio"
    notify = true
    use_nerdfont = true

    [keybindings]
    "Ctrl+q" = "quit"

    [theme]
    background = "#111111"
    primary = "#bbbbbb"
    secondary = "#232323"
    title = "#bbbbbb"
    playing = "#30d158"
    playing_selected = "#0a84ff"
    playing_bg = "#111111"
    highlight = "#0a84ff"
    highlight_bg = "#111111"
    error = "#bbbbbb"
    error_bg = "#ff453a"
    statusbar_progress = "#0a84ff"
    statusbar_progress_bg = "#111111"
    statusbar = "#bbbbbb"
    statusbar_bg = "#232323"
    cmdline = "#bbbbbb"
    cmdline_bg = "#111111"
    search_match = "#ff375f"
  '';
}
