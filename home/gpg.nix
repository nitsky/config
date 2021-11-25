user:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    yubikey-manager
    yubikey-personalization
  ];
  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";
    sshKeys = [ user.sshKeyKeygrip ];
  };
}
