user:
{ pkgs, ... }: {
  programs.gpg = {
    enable = true;
  };
  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-ssh-support
  '';
  home.file.".gnupg/sshcontrol".text = ''
   ${user.sshKeyKeygrip}
  '';
  programs.zsh.initExtra = ''
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
  '';
  # services.gpg-agent = {
  #   enable = true;
  # };
}
