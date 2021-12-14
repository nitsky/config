user:
{ ... }: {
  imports = [
    ./bat.nix
    ./fzf.nix
    (import ./git.nix user)
    (import ./gpg.nix user)
    ./htop.nix
    ./lf
    ./nvim
    ./pass.nix
    (import ./programs.nix user)
    ./rust.nix
    ./spotify.nix
    ./ssh.nix
    ./tmux
    # ./vscode.nix
    ./zsh
  ]
  ++ (if user.system == "x86_64-linux" then [
    # ./alacritty.nix
    # (import ./firefox.nix user)
    # ./sway
    # ./xdg.nix
    # linuxPackages.perf
  ] else []);
}
