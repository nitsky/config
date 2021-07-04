{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo-expand
    cargo-license
    cargo-outdated
    cargo-udeps
    rustup
    trunk
    wasm-bindgen-cli
  ];
}
