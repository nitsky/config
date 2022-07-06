{
  inputs = {
    fenix = { url = "github:nix-community/fenix"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = { url = "github:nixos/nixpkgs/release-22.05"; };
  };
  outputs = inputs:
    let
      system = "aarch64-darwin";
      pkgs = import inputs.nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        babybeluga = import ./machines/babybeluga.nix inputs;
        babyshark = import ./machines/babyshark.nix inputs;
      };
      homeConfigurations = {
        nitsky = inputs.home-manager.lib.homeManagerConfiguration {
          inherit system;
          username = "nitsky";
          homeDirectory = "/Users/nitsky";
          extraSpecialArgs = {
            inherit inputs system;
            hostname = "piper";
          };
          configuration.imports = [ ./users/nitsky.nix ];
        };
        isabella = inputs.home-manager.lib.homeManagerConfiguration {
          inherit system;
          username = "isabella";
          homeDirectory = "/Users/isabella";
          extraSpecialArgs = {
            inherit inputs system;
            hostname = "clicky";
          };
          configuration.imports = [ ./users/isabella.nix ];
        };
      };
    } // {
      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [ inputs.home-manager.defaultPackage.${system} ];
      };
    };
}
