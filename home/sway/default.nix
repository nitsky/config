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
    font.name = "JetBrainsMono Nerd Font";
    gtk3 = {
      extraCss = ''
        * { outline-width: 0px; }
      '';
      extraConfig = {
        gtk-font-name = "JetBrainsMono Nerd Font 16";
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
    "sway/cwd.sh" = {
      executable = true;
      source = ./cwd.sh;
    };
    "sway/choose_output.sh" = {
      executable = true;
      source = ./choose_output.sh;
    };
    "wofi/config".text = ''
      prompt=
      matching=fuzzy
      term=alacritty
    '';
    "wofi/style.css".text = ''
      #window {
        background: #333333;
        font-family: JetBrainsMono Nerd Font;
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
      output_name=eDP-1
      exec_before="notify-send 'Screen sharing started.'"
      exec_after="notify-send 'Screen sharing ended.'"
      chooser_type=dmenu
      chooser_cmd="wofi --dmenu"
    '';
  };
}
