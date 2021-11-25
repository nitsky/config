user:
{ ... }: {
  imports = [
    ./alacritty.nix
    ./bat.nix
    (import ./firefox.nix user)
    ./fzf.nix
    (import ./git.nix user)
    (import ./gpg.nix user)
    ./htop.nix
    ./lf
    ./nvim
    ./pass.nix
    (import ./pim.nix user)
    ./programs.nix
    ./rust.nix
    ./spotify.nix
    ./ssh.nix
    ./sway
    ./tmux
    ./vscode.nix
    ./xdg.nix
    ./zsh
  ];
}
