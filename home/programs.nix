{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [
    aerc
    awscli2
    binutils
    (pkgs.chromium.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --force-dark-mode";
    })
    cmake
    cowsay
    deno
    dnsutils
    elixir
    exa
    fd
    file
    fortune
    gcc
    gh
    gnome3.adwaita-icon-theme
    gnumake
    hexyl
    htop
    hyperfine
    inputs.tangram.defaultPackage.x86_64-linux
    jq
    mpv
    neovim
    nodejs-16_x
    nodePackages.http-server
    obs-studio
    pavucontrol
    pkg-config
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
