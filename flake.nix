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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tangram = {
      url = "github:tangramxyz/tangram/ede1310e1adf1b16e017651d9437c60127f2f8a6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    nixosConfigurations = {
      babyshark = import ./machines/babyshark.nix inputs;
      snowflake = import ./machines/snowflake.nix inputs;
      vader = import ./machines/vader.nix inputs;
    };
  };
}
