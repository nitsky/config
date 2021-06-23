inputs: {
  nixpkgs.overlays = with inputs; [
    fenix.overlay
    neovim-nightly-overlay.overlay
  ];
}
