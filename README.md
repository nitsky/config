NixOS Installation Instructions:

```
sudo parted /dev/nvme0n1 -- mklabel gpt
sudo parted /dev/nvme0n1 -- mkpart "esp" fat32 1MiB 512MiB
sudo parted /dev/nvme0n1 -- set 1 esp on
sudo parted /dev/nvme0n1 -- mkpart "root" ext4 512MiB 100%
sudo cryptsetup luksFormat /dev/nvme0n1p2
sudo cryptsetup open /dev/nvme0n1p2 crypt
sudo pvcreate /dev/mapper/crypt
sudo vgcreate vg /dev/mapper/crypt
sudo lvcreate -L 64G vg -n swap
sudo lvcreate -L 128G vg -n root
sudo lvcreate -l 100%FREE vg -n home
sudo mkfs.fat -F32 /dev/nvme0n1p1
sudo mkswap /dev/vg/swap
sudo swapon /dev/vg/swap
sudo mkfs.ext4 /dev/vg/root
sudo mkfs.ext4 /dev/vg/home
sudo mkdir /mnt
sudo mount /dev/vg/root /mnt
sudo mkdir /mnt/boot
sudo mount /dev/nvme0n1p1 /mnt/boot
sudo mkdir /mnt/home
sudo mount /dev/vg/home /mnt/home
```

Edit `/etc/nixos/configuration.nix`:

```
boot.kernelPackages = pkgs.linuxPackages_latest;
boot.initrd.luks.devices.crypt.device = "/dev/nvme0n1p2";
nix.package = pkgs.nixUnstable;
nix.extraOptions = ''
  experimental-features = nix-command flakes
'';
environment.systemPackages = with pkgs; [ vim git ];
```

```
sudo nixos-install
```

macOS Installation instructions:

Install karabiner elements and install the caps lock control escape rule from the library.
Install Rectangle and set the left half, right half, and maximize rules.

```
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
nix-shell -p nix-info --run "nix-info -m"
nix-env -iA nixpkgs.nixFlakes
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
```
