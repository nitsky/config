{ ... }: {
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./init.vim;
  };
}
