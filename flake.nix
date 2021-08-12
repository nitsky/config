{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    status = {
      url = "path:./status";
    };
    tangram = {
      url = "github:tangramdotdev/tangram/v0.7.0";
    };
  };
  outputs = inputs: {
    nixosConfigurations = {
      babybeluga = import ./machines/babybeluga.nix inputs;
      babyshark = import ./machines/babyshark.nix inputs;
      vader = import ./machines/vader.nix inputs;
    };
  };
}
