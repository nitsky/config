{ ... }: {
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        theme = "base16";
      };
    };
    extraConfig = {
      diff = {
        compactionHeuristic = true;
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {
        default = "simple";
      };
    };
    signing = {
      key = "";
      signByDefault = false;
    };
    userName = "David Yamnitsky";
    userEmail = "david@yamnitsky.com";
  };
}
