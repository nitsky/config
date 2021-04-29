{ pkgs, ... }: {
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        backend = "pulseaudio";
        device_name = "spotifyd";
        no_audio_cache = true;
        password_cmd = "gopass spotify.com/david@yamnitsky.com";
        username = "davidyamnitsky";
      };
    };
  };
  services.playerctld.enable = true;
  home.packages = with pkgs; [
    spotify-tui
  ];
}
