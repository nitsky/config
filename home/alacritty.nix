{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };
      window = {
        padding = {
          x = 6;
          y = 6;
        };
      };
      font = {
        size = 12.0;
        offset = {
          x = 0;
          y = 0;
        };
      };
      colors = {
        primary = {
          background = "0x181818";
          foreground = "0xbbbbbb";
        };
        normal = {
          black = "0xbbbbbb";
          red = "0xff453a";
          green = "0x30d158";
          yellow = "0xffd60a";
          blue = "0x0a84ff";
          magenta = "0xff375f";
          cyan = "0x4dd0e1";
          white = "0xbbbbbb";
        };
        bright = {
          black = "0xbbbbbb";
          red = "0xff453a";
          green = "0x30d158";
          yellow = "0xffd60a";
          blue = "0x0a84ff";
          magenta = "0xff375f";
          cyan = "0x4dd0e1";
          white = "0xbbbbbb";
        };
      };
      key_bindings = [
      { key = "C"; mods = "Control"; action = "Copy"; }
      { key = "V"; mods = "Control"; action = "Paste"; }
      { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
      { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
      { key = "Equals"; mods = "Control"; action = "IncreaseFontSize"; }
      { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
      { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
      ];
      mouse = {
        url = {
          launcher = {
            program = "firefox";
          };
        };
      };
    };
  };
}
