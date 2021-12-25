inputs:
let
  system = "x86_64-linux";
in
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    { system.stateVersion = "20.09"; }
    (import ./common.nix inputs)
    ({ pkgs, lib, ... }: {
      networking.hostName = "babyshark";
      users.users.nitsky = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" "libvirtd" ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keyFiles = [ ../users/nitsky.public.rsa ../users/isabella.public.rsa ];
      };
      users.users.isabella = {
        isNormalUser = true;
        createHome = true;
        extraGroups = [ "wheel" "libvirtd" ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keyFiles = [ ../users/nitsky.public.rsa ../users/isabella.public.rsa ];
      };
      boot = {
        binfmt.emulatedSystems = [
          "aarch64-linux"
        ];
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
        kernelModules = [ "kvm-amd" "kvm-intel" ];
        kernelParams = [
          "quiet"
          "udev.log_priority=3"
          "mem_sleep_default=deep"
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
    })
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit inputs;
        inherit system;
        hostname = "babyshark";
      };
      home-manager.users.nitsky = import ../users/nitsky.nix;
      home-manager.users.isabella = import ../users/isabella.nix;
    }
  ];
}
