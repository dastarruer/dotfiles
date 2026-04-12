{inputs, ...}: {
  flake.nixosModules.core = {...}: {
    # Suppress warning (https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion)
    system.stateVersion = "25.05";

    nixpkgs.config.allowUnfree = true;
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    nix = {
      # For nixd i think
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      settings = {
        max-jobs = "auto";

        # Enable flakes
        experimental-features = ["nix-command" "flakes"];

        # Use nix-community binary cache to avoid building from source as much as possible
        extra-substituters = [
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
  };
}
