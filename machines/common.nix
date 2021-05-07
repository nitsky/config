{ config, lib, pkgs, ... }: {
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;

  security.sudo.wheelNeedsPassword = false;

  networking = {
    useDHCP = false;
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["tailscale0"];
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/New_York";
  documentation.doc.enable = false;

  sound.enable = true;
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
    openssh.enable = true;
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
  };
  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --time --asterisks --cmd sway";
        command = "sway --config /etc/sway-greetd.conf";
      };
    };
  };
  environment.etc."sway-greetd.conf".text = ''
    output DP-1 scale 1.5
    output eDP-1 scale 2
    bindsym Mod4+q exec swaynag \
      -t warning \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
    seat seat0 xcursor_theme Adwaita
    exec "GTK_THEME=Adwaita:dark ${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -c sway; swaymsg exit"
  '';

  environment.systemPackages = with pkgs; [
    git
    sof-firmware
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
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "JetBrainsMono Nerd Font" ];
        serif = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  virtualisation = {
    podman = {
      enable = true;
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
