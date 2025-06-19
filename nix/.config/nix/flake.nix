{
  description = "My NixOS system made by me";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    spicetify-nix,
    nix-flatpak,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.dastarruer = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix
        spicetify-nix.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
      ];

      specialArgs = {
        inherit inputs;
        spicePkgs = spicetify-nix.legacyPackages.${system};
      };
    };
  };
}
