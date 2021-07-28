{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
    };
    tangram = {
      url = "github:tangramdotdev/tangram/v0.6.0";
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
