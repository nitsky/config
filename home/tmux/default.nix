{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    newSession = true;
    resizeAmount = 10;
    terminal = "screen-256color";
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
