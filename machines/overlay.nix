inputs: {
  nixpkgs.overlays = with inputs; [
    fenix.overlay
  ];
}
