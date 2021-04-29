inputs: {
  nixpkgs.overlays = [
    inputs.nur.overlay
    inputs.neovim-nightly-overlay.overlay
  ];
}
