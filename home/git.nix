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
      alias = {
        l = "log --all --graph --decorate --abbrev-commit --format=format:'%C(bold blue)%h%C(reset) - %C(bold white)%an%C(reset) %C(bold yellow)%d%C(reset)%n%C(bold cyan)%aD%C(reset) - %C(bold green)(%ar)%C(reset)%n%C(white)%s%C(reset)'";
      };
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
