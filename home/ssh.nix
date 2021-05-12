{ ... }: {
  programs.ssh = {
    enable = true;
    controlMaster = "yes";
    forwardAgent = true;
  };
}
