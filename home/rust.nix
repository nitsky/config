{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo-cross
    cargo-outdated
    rust-analyzer
    rustup
  ];
  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    rustflags = ["-C", "link-arg=-fuse-ld=lld"]
  '';
}
