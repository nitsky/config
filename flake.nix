{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
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
    };
    homeConfigurations = {
      nitsky = inputs.home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        username = "nitsky";
        homeDirectory = "/Users/nitsky";
        extraSpecialArgs = {
          inherit inputs;
          system = "aarch64-darwin";
          hostname = "bigbird";
        };
        configuration.imports = [ ./users/nitsky.nix ];
      };
      isabella = inputs.home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        username = "isabella";
        homeDirectory = "/Users/isabella";
        extraSpecialArgs = {
          inherit inputs;
          system = "aarch64-darwin";
          hostname = "mba";
        };
        configuration.imports = [ ./users/isabella.nix ];
      };
    };
  }
  //
  inputs.flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import inputs.nixpkgs { 
      inherit system; 
    };
    in {
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          inputs.home-manager.defaultPackage.${system}
        ];
      };
    }
  );
}
