{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    dirHashes = {};
    initExtraFirst = builtins.readFile ./zshrc + builtins.readFile ../lf/icons;
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
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
