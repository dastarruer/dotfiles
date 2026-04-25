{inputs, ...}: {
  flake.nixosModules.core = {
    pkgs,
    lib,
    ...
  }: {
    # Suppress warning (https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion)
    system.stateVersion = "25.05";

    nixpkgs.config.allowUnfree = true;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      # Delete any files that home-manager is too scared to overwrite
      # It's ok home manager, you can do what you want. stop FAILING BECAUSE YOU CAN'T DELETE A GODDAMN FILE-
      # 'o-oh i just don't want to delete anything i shouldnt-' THAT'S THE WHOLE POINT OF USING YOU DELETE IT PLEASE
      backupCommand = "${lib.getExe pkgs.trash-cli}";
    };

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
