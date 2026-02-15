{
  description = "My NixOS system made by me";

  inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs";

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
    # flatpaks = {
    #   url = "github:dastarruer/declarative-flatpak/fix/use-tmpfiles-settings";
    #   # rev = "fix/use-tmpfiles-settings";
    # };

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

    # split-monitor-workspaces = {
    #   url = "github:Duckonaut/split-monitor-workspaces";
    #   inputs.hyprland.follows = "hyprland";
    # };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

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
      specialArgs = {inherit inputs system;};
      modules = [
        inputs.stylix.nixosModules.stylix
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager # home-manager nixos module
        inputs.ucodenix.nixosModules.default
        inputs.disko.nixosModules.disko

        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
        ./hosts/laptop/disko-config.nix
        ./modules/nixos/default.nix

        {
          home-manager.useUserPackages = true;
          # home-manager.useGlobalPkgs = true;
          home-manager.backupFileExtension = "bak";

          # Pass the same extraSpecialArgs from nixos
          home-manager.extraSpecialArgs = {
            inherit inputs system;
            spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
            firefoxAddonPkgs = inputs.firefox-addons.packages.${system};
            vscode-extensions = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
            hyprlandPlugins = inputs.hyprland-plugins.packages.${system};
          };

          # Define the user and their modules
          home-manager.users.dastarruer = {
            imports = [
              inputs.stylix.homeModules.stylix
              inputs.sops-nix.homeManagerModules.sops
              inputs.flatpaks.homeModules.default
              inputs.spicetify-nix.homeManagerModules.spicetify
              inputs.textfox.homeManagerModules.default

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
