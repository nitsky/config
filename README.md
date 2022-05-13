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
sudo lvcreate -L 256G vg -n root
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
nix.extraOptions = ''
  experimental-features = nix-command flakes
'';
environment.systemPackages = with pkgs; [ vim git ];
```

```
sudo nixos-install
```

## GPG Key Setup

```
export NAME="John Doe"
export EMAIL="john@example.com"
gpg --quick-generate-key "$NAME <$EMAIL>" ed25519 cert never
export KEYFP=$(gpg -k --with-colons $EMAIL | awk -F: '$1 == "fpr" { print $10 }')
gpg --quick-add-key $KEYFP ed25519 sign never
gpg --quick-add-key $KEYFP cv25519 encr never
gpg --quick-add-key $KEYFP ed25519 auth never
```

# list public keys
gpg -k

# list private keys
gpg -K

# Get SSH public key
gpg --export-ssh-key $EMAIL

# ~/.gnupg/sshcontrol
gpg -k --with-keygrip

# reload gpg
gpg-connect-agent reloadagent /bye
