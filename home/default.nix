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
    ./programs.nix
    ./rust.nix
    ./spotify.nix
    ./ssh.nix
    ./tmux
    ./vscode.nix
    ./zsh
  ]
  ++ (if user.system == "x86_64-linux" then [
    ./sway
    ./xdg.nix
  ] else []);
}
