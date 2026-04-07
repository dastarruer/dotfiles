{inputs, ...}: {
  flake.nixosModules.core = {...}: {
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
