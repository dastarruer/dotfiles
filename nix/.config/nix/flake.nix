{
  description = "My NixOS system made by me";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/dev";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    spicetify-nix,
    flatpaks,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.dastarruer = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix
        spicetify-nix.nixosModules.default
        flatpaks.nixosModule
      ];

      specialArgs = {
        inherit inputs;
        spicePkgs = spicetify-nix.legacyPackages.${system};
      };
    };
  };
}
