{ pkgs, ... }: {
  home.packages = with pkgs; [
    aerc
    binutils
    (pkgs.chromium.override {
      commandLineArgs = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
        --enable-features=VaapiVideoDecoder
        --force-dark-mode
        --enable-features=WebUIDarkMode
      '';
    })
    cowsay
    dnsutils
    exa
    fd
    fortune
    gcc
    gnome3.adwaita-icon-theme
    gopass
    htop
    hyperfine
    jq
    nodejs-16_x
    nodePackages.http-server
    pavucontrol
    postgresql
    python39
    ripgrep
    rust-analyzer
    rustup
    tokei
    unzip
    vim
    wally-cli
    xh
  ];
}
