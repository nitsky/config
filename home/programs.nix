{ pkgs, ... }: {
  home.packages = with pkgs; [
    aerc
    awscli2
    binutils
    (pkgs.chromium.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --force-dark-mode";
    })
    cowsay
    dnsutils
    exa
    fd
    fortune
    gcc
    gnome3.adwaita-icon-theme
    hexyl
    htop
    hyperfine
    jq
    nodejs-16_x
    nodePackages.http-server
    obs
    pavucontrol
    postgresql
    pup
    python39
    ripgrep
    tokei
    unzip
    vim
    wally-cli
    xh
  ];
}
