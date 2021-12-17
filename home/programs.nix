user:
{ inputs, pkgs, system, ... }: {
  home.packages = with pkgs; [
    aerc
    awscli2
    binutils
    cmake
    cowsay
    deno
    dnsutils
    elixir
    exa
    fd
    file
    fortune
    gh
    gnumake
    gnused
    helix
    hexyl
    htop
    hyperfine
    jq
    kakoune
    killall
    nixfmt
    nodejs-16_x
    nodePackages.http-server
    pkg-config
    postgresql
    pup
    python3
    qemu
    ripgrep
    sd
    tokei
    unzip
    vim
    wally-cli
    xh
    xsv
  ]
  ++ (if user.system == "x86_64-linux" then [
    (pkgs.chromium.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --force-dark-mode";
    })
    gcc
    gnome3.adwaita-icon-theme
    imv
    inputs.status.defaultPackage.${system}
    inputs.tangram.defaultPackage.${system}
    mold
    mpv
    obs-studio
    openrgb
    pavucontrol
    slack
    usbutils
    virt-manager
    zoom-us
  ] else []);
}
