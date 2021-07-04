{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    aerc
    awscli2
    binutils
    (pkgs.chromium.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --force-dark-mode";
    })
    cowsay
    dnsutils
    elixir
    exa
    fd
    fortune
    gcc
    gh
    gnome3.adwaita-icon-theme
    hexyl
    htop
    hyperfine
    inputs.tangram.defaultPackage.x86_64-linux
    jq
    mpv
    nodejs-16_x
    nodePackages.http-server
    obs-studio
    pavucontrol
    postgresql
    pup
    python3
    ripgrep
    tokei
    unzip
    vim
    wally-cli
    xh
    zig
  ];
}
