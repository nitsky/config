{ ... }: {
  programs.htop = {
    enable = true;
    hideThreads = true;
    hideKernelThreads = true;
    hideUserlandThreads = true;
    showProgramPath = false;
    treeView = true;
    vimMode = true;
  };
}
