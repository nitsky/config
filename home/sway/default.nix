{ pkgs, hostname, ... }: {

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
    gtk3 = {
      extraCss = ''
        * { outline-width: 0px; }
      '';
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    brightnessctl
    grim
    libnotify
    pamixer
    playerctl
    slurp
    swayidle
    swaylock
    wayvnc
    wf-recorder
    wl-clipboard
    wofi
    xdg-utils
  ];

  programs.i3status-rust = {
    enable = true;
    bars.top = {
      blocks = (if (hostname == "babybeluga") then [
        {
          block = "backlight";
        }
        {
          block = "battery";
          interval = 1;
          format = "{percentage}";
          allow_missing = true;
          hide_missing = true;
        }
      ] else [])
      ++
      [
        {
          block = "net";
          format = "";
          interval = 1;
        }
        {
          block = "sound";
          show_volume_when_muted = true;
        }
        {
          block = "time";
          interval = 1;
          format = "%a %m/%d %R";
        }
      ];
      icons = "material-nf";
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
    "sway/cwd.sh" = {
      executable = true;
      source = ./cwd.sh;
    };
    "sway/choose_output.sh" = {
      executable = true;
      source = ./choose_output.sh;
    };
    "sway/emoji.sh" = {
      executable = true;
      source = ./emoji.sh;
    };
    "wofi/config".text = ''
      prompt=
      matching=fuzzy
      term=alacritty
    '';
    "wofi/style.css".text = ''
      #window {
        background: #333333;
      }
      #input {
        background: #333333;
        border-radius: 0px;
        border: none;
      }
      #entry:selected {
        background: #0A84FF;
        outline: none;
      }
    '';
    "swaylock/config".text = ''
      color=000000FF
      daemonize
      ignore-empty-password
      scaling=fit
    '';
    "xdg-desktop-portal-wlr/config".text = ''
      [screencast]
      exec_before=notify-send 'Screen sharing started.'
      exec_after=notify-send 'Screen sharing ended.'
      chooser_type=dmenu
      chooser_cmd=wofi --dmenu
    '';
  };
}
