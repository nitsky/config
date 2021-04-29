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
sudo mount /dev/vg/home /mnt
sudo nixos-install --flake github.com/nitsky/config#HOST
```
