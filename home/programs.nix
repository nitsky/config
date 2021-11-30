{ inputs, pkgs, system, ... }: {
  home.packages = with pkgs; [
    aerc
    awscli2
    binutils
    # (pkgs.chromium.override {
    #   commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --force-dark-mode";
    # })
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
    imv
    inputs.status.defaultPackage.${system}
    inputs.tangram.defaultPackage.${system}
    jq
    killall
    mpv
    nixfmt
    nodejs-16_x
    nodePackages.http-server
    obs-studio
    openrgb
    pavucontrol
    pkg-config
    postgresql
    pup
    python3
    qemu
    ripgrep
    sd
    slack
    tmux
    tokei
    unzip
    usbutils
    vim
    wally-cli
    xh
    zig
    zoom-us
  ];
}
