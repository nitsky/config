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
    ./neovim
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
