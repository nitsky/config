inputs:
{ config, lib, pkgs, ... }: {
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;

  nix.binaryCaches = lib.mkForce [
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
    "https://tangram.cachix.org"
    "http://babyshark:5000"
  ];
  nix.binaryCachePublicKeys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "tangram.cachix.org-1:NQ5Uzhhbrgi4R6A0JoljrMg8X4a2doTv3WrSnajJANs="
    "babyshark:oaz6/nqu5aJkyh1TkdUHcRH1ggGDgrjQs37NmQLF5ug="
  ];
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/etc/nix-serve.private.key";
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    useDHCP = false;
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["tailscale0"];
    hosts = {
      "100.94.50.82" = [ "babybeluga" ];
      "100.100.213.21" = [ "babyshark" ];
      "100.89.221.9" = [ "mba" ];
      "100.121.28.94" = [ "snowflake" ];
      "100.87.20.70" = [ "vader" ];
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/New_York";
  documentation.doc.enable = false;

  sound.enable = false;
  hardware = {
    enableRedistributableFirmware = true;
    keyboard.zsa.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  services = {
    dbus.packages = with pkgs; [ gnome3.dconf gcr ];
    fwupd.enable = true;
    kmscon = {
      enable = true;
      hwRender = true;
      extraOptions = "--font-dpi=192";
    };
    openssh = {
      enable = true;
      openFirewall = false;
    };
    pcscd.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    printing.enable = true;
    tailscale.enable = true;
    udev.packages = [
      pkgs.yubikey-personalization
    ];
    udisks2.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      gnome3.adwaita-icon-theme
    ];
  };
  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "sway --config /etc/greetd/sway";
      };
    };
  };
  environment.etc."greetd/sway".text = ''
    exec systemctl --user import-environment
    output * background #000000 solid_color
    output * scale 1.5
    bindsym mod4+q exec swaynag \
      -t warning \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
    seat seat0 xcursor_theme Adwaita
    exec "GTK_THEME=Adwaita:dark ${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s /etc/greetd/gtkgreet.css -c sway; swaymsg exit"
  '';
  environment.etc."greetd/gtkgreet.css".text = ''
    window { background-color: #000000; }
  '';

  environment.systemPackages = with pkgs; [
    git
    sof-firmware
    vim
  ];

  programs.bash.promptInit = ''
    PS1="$ "
  '';
  programs.dconf.enable = true;
  security.pam.services.swaylock = {};

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      noto-fonts-emoji
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        sansSerif = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        serif = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      };
    };
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    gtkUsePortal = true;
  };
}
