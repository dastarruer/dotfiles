{
  description = "My nixos system made by me";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.dastarruer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        inputs.spicetify-nix.nixosModules.default
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];
      specialArgs = {
        inherit inputs;
      };
    };
  };
}
