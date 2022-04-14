user:
{ ... }: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    (import ./git.nix user)
    (import ./gpg.nix user)
    ./htop.nix
    ./kitty
    ./lf
    ./nvim
    ./pass.nix
    (import ./programs.nix user)
    ./rust.nix
    ./spotify.nix
    ./ssh.nix
    ./tmux
    ./zsh
  ]
  ++ (if user.system == "x86_64-linux" then [
    ./alacritty.nix
    (import ./firefox.nix user)
    ./sway
    ./xdg.nix
  ] else [ ]);
}
