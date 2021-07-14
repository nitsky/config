{ pkgs, ... }: {
  xdg.configFile."nvim/lua/config.lua".text = builtins.readFile ./config.lua;
}
