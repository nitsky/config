user:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    pinentry
  ];
  programs.gpg = {
    enable = true;
  };
  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-ssh-support
    pinentry-program ${pkgs.pinentry.curses}/bin/pinentry
  '';
  home.file.".gnupg/sshcontrol".text = ''
    ${user.sshKeyKeygrip}
  '';
  programs.zsh.initExtra = ''
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
  '';
  # services.gpg-agent = {
  #   enable = true;
  # };
}
