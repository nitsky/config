{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo-expand
    cargo-license
    cargo-outdated
    rust-analyzer
    rustup
    trunk
    wasm-bindgen-cli
  ];
}
