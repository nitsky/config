inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "20.09"; }
    (import ./overlay.nix inputs)
    ./common.nix
    ({ pkgs, lib, ... }: {
      networking.hostName = "vader";
      users.users.nitsky = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };
      users.users.isabella = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };
      boot = {
        blacklistedKernelModules = [ "psmouse" ];
        consoleLogLevel = 0;
        initrd = {
          availableKernelModules = [
            "ahci"
            "nvme"
            "sd_mod"
            "usb_storage"
            "usbhid"
            "xhci_pci"
          ];
          kernelModules = [
            "dm-snapshot"
          ];
          luks.devices.crypt.device = "/dev/nvme0n1p2";
          verbose = false;
        };
        kernelModules = [ "kvm-amd" ];
        kernelParams = [
          "quiet"
          "udev.log_priority=3"
        ];
        loader = {
          efi.canTouchEfiVariables = true;
          systemd-boot.enable = true;
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