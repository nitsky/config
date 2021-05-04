{ pkgs, ... }: {
  home.packages = with pkgs; [
    aerc
    kitty
    gnome3.gnome-terminal
    binutils
    cowsay
    exa
    fd
    fortune
    gcc
    gnome3.adwaita-icon-theme
    gopass
    htop
    hyperfine
    jq
    pavucontrol
    python3
    ripgrep
    rustup
    rust-analyzer
    tokei
    vim
    wally-cli
    xh
  ];
  # pkgs.chromium.override {
  #   commandLineArgs = ''
  #     --enable-features=UseOzonePlatform
  #     --ozone-platform=wayland
  #     --enable-features=VaapiVideoDecoder
  #     --force-dark-mode
  #     --enable-features=WebUIDarkMode
  #   '';
  # };
}
