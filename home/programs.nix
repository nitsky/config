user:
{ inputs, pkgs, system, ... }: {
  home.packages = with pkgs; [
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
    ghc
    glow
    gnumake
    gnused
    helix
    hexyl
    htop
    hyperfine
    jq
    kakoune
    killall
    mosh
    nixfmt
    nixpkgs-fmt
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
    # inputs.swaystatus.defaultPackage.${system}
    inputs.tangram.defaultPackage.${system}
    mold
    mpv
    obs-studio
    openrgb
    pavucontrol
    slack
    usbutils
    virt-manager
    vscode
    zoom-us
  ] else [ ]);
}
