{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    fenix = {
      url = "github:nix-community/fenix";
    };
  };
  outputs = { nixpkgs, flake-utils, fenix, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      rust = (with fenix.packages.${system}; combine [
        rust-analyzer
        stable.cargo
        stable.clippy-preview
        stable.rust-src
        stable.rust-std
        stable.rustc
        stable.rustfmt-preview
      ]);
    in rec {
      defaultApp = flake-utils.lib.mkApp {
        drv = defaultPackage;
      };
      defaultPackage = (pkgs.makeRustPlatform {
        rustc = rust;
        cargo = rust;
      }).buildRustPackage {
        pname = "status";
        version = "0.0.0";
        src = ./.;
        doCheck = false;
        buildInputs = with pkgs; [
          libpulseaudio
        ];
        nativeBuildInputs = with pkgs; [
          pkg-config
          rust
        ];
        cargoSha256 = "sha256-qfnnvw3aF9/jzswICMWekoU9PWOYGgpDb2ruG4wXltw=";
      };
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          libpulseaudio
          pkg-config
          rust
        ];
      };
    }
  );
}
