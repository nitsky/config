{ pkgs, ... }: {
  home.packages = with pkgs; [
    aerc
    cowsay
    exa
    fd
    fortune
    gnome3.adwaita-icon-theme
    gopass
    htop
    jq
    pavucontrol
    ripgrep
    rustup
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
