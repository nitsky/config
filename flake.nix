{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/15679e7c2017a3f23b5f6a54b00695768968321f";
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
