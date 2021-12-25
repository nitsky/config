{ ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  programs.zsh.envExtra = ''
    export DIRENV_LOG_FORMAT=""
  '';
  xdg.configFile."direnv/config.toml".text = ''
    [global]
    warn_timeout = "1000s"
  '';
}
