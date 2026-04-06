{...}: {
  flake.nixosModules.cli_direnv = {config, ...}: {
    home-manager.users.dastarruer = {
      programs.direnv = {
        enable = true;
        enableFishIntegration = config.programs.fish.enable;

        # For nix flake integration
        nix-direnv.enable = true;
      };
    };
  };
}
