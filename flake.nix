{
  description = "My NixOS system made by me";

  inputs = {
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

    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/v3.0.0";
    # flatpaks = {
    #   url = "github:dastarruer/declarative-flatpak/fix/use-tmpfiles-settings";
    #   # rev = "fix/use-tmpfiles-settings";
    # };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

    # split-monitor-workspaces = {
    #   url = "github:Duckonaut/split-monitor-workspaces";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # Microcode updates
    cpu-microcodes = {
      url = "github:platomav/CPUMicrocodes/ec5200961ecdf78cf00e55d73902683e835edefd";
      flake = false;
    };

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
    pkgs = import nixpkgs {inherit system;};
  in {
    # NixOS configuration (system only)
    nixosConfigurations.dastarruer = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs system;
      };
      modules = [
        inputs.stylix.nixosModules.stylix
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        inputs.ucodenix.nixosModules.default

        ./hosts/laptop/configuration.nix
      ];
    };

    # Laptop
    homeConfigurations.dastarruer = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs system;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
        firefoxPkgs = inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system};
        firefoxAddonPkgs = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
        vscode-extensions = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
      };
      modules = [
        inputs.stylix.homeModules.stylix
        inputs.sops-nix.homeManagerModules.sops
        inputs.flatpaks.homeModule
        inputs.spicetify-nix.homeManagerModules.spicetify

        ./hosts/laptop/home.nix
      ];
    };

    # Steam deck
    homeConfigurations.deck = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs system;
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
        firefoxPkgs = inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system};
        firefoxAddonPkgs = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
        vscode-extensions = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
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
