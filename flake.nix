{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable-small";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay ={
      url = "github:nix-community/neovim-nightly-overlay";
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
