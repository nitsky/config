{ pkgs, inputs, system, ... }: {
  home.packages = with pkgs; [
    cargo-asm
    cargo-expand
    cargo-flamegraph
    cargo-license
    cargo-outdated
    cargo-udeps
    rust-analyzer
    rustup
    trunk
    wasm-bindgen-cli
    zig
  ];
}
