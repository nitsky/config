{ pkgs, ... }: {

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = null;
    xwayland = false;
    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND="1"
      export XDG_CURRENT_DESKTOP="sway"
      export XDG_SESSION_TYPE="wayland"
    '';
    extraConfig = builtins.readFile ./config;
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita";
    iconTheme = {
      package = pkgs.gnome3.adwaita-icon-theme;
      name = "Adwaita";
    };
    gtk3 = {
      extraCss = ''
        * { outline-width: 0px; }
      '';
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };

  home.packages = with pkgs; [
    brightnessctl
    grim
    libnotify
    pamixer
    playerctl
    slurp
    swaycwd
    swayidle
    swaylock
    wayvnc
    wf-recorder
    wl-clipboard
    xdg-utils
  ];

  programs.i3status-rust = {
    enable = true;
    bars.top = {
      blocks = [
        {
          block = "sound";
        }
        {
          block = "time";
          interval = 60;
          format = "%a %m/%d %R";
        }
      ];
      icons = "awesome5";
      theme = "native";
    };
  };

  programs.mako = {
    enable = true;
    defaultTimeout = 1000;
    extraConfig = ''
      background-color=#232323
      border-size=0
      [urgency=normal]
      background-color=#0A84FF
      [urgency=high]
      background-color=#FF453A
    '';
  };

  xdg.configFile = {
    "sway/wallpaper.png".source = ./wallpaper.png;
    "swaylock/config".text = ''
      color=000000FF
      daemonize
      ignore-empty-password
      image=~/.config/sway/wallpaper.png
      scaling=fit
    '';
    "xdg-desktop-portal-wlr/config".text = ''
      [screencast]
      output_name=eDP-1
      exec_before="notify-send 'screensharing started'"
      exec_after="notify-send 'screensharing ended'"
      chooser_type=simple
      chooser_cmd="slurp -f %o -o"
    '';
  };
}
