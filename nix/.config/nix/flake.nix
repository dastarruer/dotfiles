{
  description = "My NixOS Flake Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    # Pywalfox stuff because nix hates all of us and packages dont work and the world is falling apart and yk what-
    pywalfox = pkgs.python3Packages.buildPythonPackage {
      pname = "pywalfox";
      version = "2.8.0rc1";

      src = pkgs.fetchFromGitHub {
        owner = "Frewacom";
        repo = "pywalfox-native";
        rev = "7ecbbb193e6a7dab424bf3128adfa7e2d0fa6ff9";
        hash = "sha256-i1DgdYmNVvG+mZiFiBmVHsQnFvfDFOFTGf0GEy81lpE=";
      };
    };
  in {
    nixosConfigurations = {
      dastarruer = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          {
            _module.args = {
              inherit nixpkgs inputs pywalfox;
            };
          }
          ./configuration.nix
        ];
      };
    };
  };
}
