{
  description = "My NixOS system made by me";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other flakes
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/dev";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      specialArgs = {
        inherit inputs system;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
      };

      modules = [
        ./nix/configuration.nix

        # Home manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.dastarruer = ./home.nix;
        }
      ];
    };
  };
}
