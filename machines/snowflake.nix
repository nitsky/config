inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "20.09"; }
    (import ./overlay.nix inputs)
    ./common.nix
    ({ pkgs, lib, ... }: {
      networking.hostName = "snowflake";
      users.users.nitsky = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keyFiles = [ ../nitsky.public.rsa ../isabella.public.rsa ];
      };
      users.users.isabella = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keyFiles = [ ../nitsky.public.rsa ../isabella.public.rsa ];
      };
      boot = {
        blacklistedKernelModules = [ "psmouse" ];
        consoleLogLevel = 0;
        initrd = {
          availableKernelModules = [
            "i915"
            "nvme"
            "rtsx_pci_sdmmc"
            "sd_mod"
            "usb_storage"
            "xhci_pci"
          ];
          kernelModules = [
            "dm-snapshot"
          ];
          luks.devices.crypt.device = "/dev/nvme0n1p2";
          verbose = false;
        };
        kernelModules = [ "kvm-intel" ];
        kernelPackages = pkgs.linuxPackages_latest;
        kernelParams = [
          "quiet"
          "udev.log_priority=3"
        ];
        kernel.sysctl = {
          "fs.inotify.max_user_watches" = "524288";
        };
        loader = {
          efi.canTouchEfiVariables = true;
          systemd-boot = {
            enable = true;
            configurationLimit = 10;
          };
        };
      };
      fileSystems."/boot" = {
        device = "/dev/nvme0n1p1";
        fsType = "vfat";
      };
      fileSystems."/" = {
        device = "/dev/mapper/vg-root";
        fsType = "ext4";
      };
      fileSystems."/home" = {
        device = "/dev/mapper/vg-home";
        fsType = "ext4";
      };
      swapDevices = [
        { device = "/dev/mapper/vg-swap"; }
      ];
      powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
      hardware.opengl.extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
      ];
      hardware.video.hidpi.enable = true;
      environment.etc."dual-function-keys.yaml".text = ''
        MAPPINGS:
          - KEY: KEY_CAPSLOCK
            TAP: KEY_ESC
            HOLD: KEY_LEFTCTRL
          - KEY: KEY_LEFTALT
            TAP: KEY_ESC
            HOLD: KEY_LEFTMETA
          - KEY: KEY_LEFTMETA
            TAP: KEY_ESC
            HOLD: KEY_LEFTALT
      '';
      services.interception-tools = {
        enable = true;
        plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
        udevmonConfig = ''
          - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
            DEVICE:
              EVENTS:
                EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
        '';
      };
    })
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.nitsky = { ... }: {
        home.stateVersion = "21.05";
        imports = [ ../users/nitsky.nix ];
      };
      home-manager.users.isabella = { ... }: {
        home.stateVersion = "21.05";
        imports = [ ../users/isabella.nix ];
      };
    }
  ];
}
