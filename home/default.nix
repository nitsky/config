{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./bat.nix
    ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./lf
    ./nvim
    ./pim.nix
    ./programs.nix
    ./spotify.nix
    ./ssh.nix
    ./sway
    ./tmux
    ./vscode.nix
    ./xdg.nix
    ./zsh
  ];
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
