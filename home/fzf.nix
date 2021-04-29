{ ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    fileWidgetCommand = "fd --type f --no-ignore";
    historyWidgetOptions = [ "--reverse" "--sort" "--exact" ];
  };
}
