{
  description = "My NixOS system made by me";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other flakes
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/dev";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.dastarruer = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix

        # Home manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dastarruer = ./home.nix;
        }

        # Other modules
        inputs.spicetify-nix.nixosModules.default
        inputs.flatpaks.nixosModule
      ];

      specialArgs = {
        inherit inputs;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
      };
    };
  };
}
