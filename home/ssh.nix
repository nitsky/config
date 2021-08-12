{ ... }: {
  programs.ssh = {
    enable = true;
    controlMaster = "yes";
    forwardAgent = true;
    extraConfig = ''
      match host * exec "gpg-connect-agent UPDATESTARTUPTTY /bye"
    '';
  };
}
