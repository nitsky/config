user:
{ ... }: {
  imports = [
    ./alacritty.nix
    ./bat.nix
    (import ./firefox.nix user)
    ./fzf.nix
    (import ./git.nix user)
    ./gpg.nix
    ./htop.nix
    ./lf
    ./nvim
    (import ./pim.nix user)
    ./programs.nix
    ./spotify.nix
    ./ssh.nix
    ./sway
    ./tmux
    ./vscode.nix
    ./xdg.nix
    ./zsh
  ];
}
