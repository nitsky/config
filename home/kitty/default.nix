{ pkgs, ... }: {
  xdg.configFile."kitty/kitty.conf".text = builtins.readFile ./kitty.conf;
}
