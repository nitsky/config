{ pkgs, ... }: {
  home.packages = with pkgs; [
    cargo-expand
    cargo-license
    cargo-outdated
    rustup
    trunk
    wasm-bindgen-cli
  ];
}
