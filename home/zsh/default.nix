{ ... }: {
  programs.zsh = {
    enable = true;
    initExtraFirst = builtins.readFile ./zshrc + builtins.readFile ../lf/icons;
  };
}
