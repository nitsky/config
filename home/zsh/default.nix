{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    dirHashes = { };
    initExtraFirst = builtins.readFile ./zshrc;
  };
}
