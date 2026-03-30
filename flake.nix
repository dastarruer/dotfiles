{
  description = "My NixOS system made by me";

  inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/latest";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # Microcode updates
    cpu-microcodes = {
      url = "github:platomav/CPUMicrocodes/ec5200961ecdf78cf00e55d73902683e835edefd";
      flake = false;
    };

    textfox.url = "github:adriankarlen/textfox";

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ucodenix = {
      url = "github:e-tho/ucodenix";
      inputs.cpu-microcodes.follows = "cpu-microcodes";
    };

    steam-config-nix = {
      url = "github:different-name/steam-config-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    betterfox = {
      url = "github:yokoffing/Betterfox/main";
      flake = false;
    };

    peacock = {
      url = "github:thepeacockproject/linux-steam-setup";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        nixd
        alejandra
      ];
    };

    nixosConfigurations.dastarruer = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs system;};
      modules = [
        inputs.stylix.nixosModules.stylix
        inputs.sops-nix.nixosModules.sops
        inputs.ucodenix.nixosModules.default
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager

        # Install comma: https://github.com/nix-community/nix-index-database?tab=readme-ov-file#usage-in-nixos
        inputs.nix-index-database.nixosModules.default
        {programs.nix-index-database.comma.enable = true;}

        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
        ./hosts/laptop/disko-config.nix
        ./modules/nixos/default.nix

        {
          home-manager.useUserPackages = true;
          # home-manager.useGlobalPkgs = true;
          home-manager.backupCommand = "${pkgs.trash-cli}/bin/trash";

          # Pass the same extraSpecialArgs from nixos
          home-manager.extraSpecialArgs = {
            inherit inputs system;
            spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
            firefoxAddonPkgs = inputs.firefox-addons.packages.${system};
            vscode-extensions = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
          };

          # Define the user and their modules
          home-manager.users.dastarruer = {
            imports = [
              inputs.stylix.homeModules.stylix
              inputs.sops-nix.homeManagerModules.sops
              inputs.flatpaks.homeModules.default
              inputs.spicetify-nix.homeManagerModules.spicetify
              inputs.textfox.homeManagerModules.default
              inputs.steam-config-nix.homeModules.default

              ./hosts/laptop/home.nix
              ./modules/home-manager/default.nix
            ];
          };
        }
      ];
    };

    # Steam deck
    homeConfigurations.deck = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          # Add your script overlays here too
        ];
      };
      extraSpecialArgs = {
        inherit inputs system;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
        firefoxPkgs = inputs.firefox-nightly.packages.${system};
        firefoxAddonPkgs = inputs.firefox-addons.packages.${system};
        vscode-extensions = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
      };
      modules = [
        inputs.stylix.homeModules.stylix
        inputs.sops-nix.homeManagerModules.sops
        inputs.flatpaks.homeModule
        inputs.spicetify-nix.homeManagerModules.spicetify

        ./hosts/steam-deck/home.nix
      ];
    };
  };
}
