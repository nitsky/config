{ pkgs, ... }: {
  home.packages = with pkgs; [ tmux ];
  xdg.configFile."tmux/tmux.conf".text = builtins.readFile ./tmux.conf;
}
