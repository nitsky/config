user:
{ ... }: {
  programs.git = {
    enable = true;
    userName = user.git.name;
    userEmail = user.git.email;
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
  };
}
