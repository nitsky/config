{ pkgs, ... }: {
  home.packages = with pkgs; [
    ncspot
  ];
  xdg.configFile."ncspot/config.toml".text = ''
    audio_cache = false
    backend = "pulseaudio"
    notify = true
    use_nerdfont = true

    [theme]
    background = "#111111"
    primary = "#bbbbbb"
    secondary = "#232323"
    title = "#bbbbbb"
    playing = "#0a84ff"
    playing_selected = "#30d158"
    playing_bg = "#111111"
    highlight = "#0a84ff"
    highlight_bg = "#111111"
    error = "#bbbbbb"
    error_bg = "#ff453a"
    statusbar = "#bbbbbb"
    statusbar_progress = "#0a84ff"
    statusbar_bg = "#232323"
    cmdline = "#bbbbbb"
    cmdline_bg = "#111111"
    search_match = "#ff375f"
  '';
}
