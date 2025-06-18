{
  description = "My system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    spicetify-nix,
    ...
  } @ inputs: {
    nixosConfigurations.dastarruer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        spicetify-nix.nixosModules.default
      ];
      specialArgs = {
        inherit inputs;
      };
    };
  };
}
