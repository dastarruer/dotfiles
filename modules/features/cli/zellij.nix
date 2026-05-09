{...}: {
  flake.nixosModules.cli_zellij = {config, ...}: {
    home-manager.users.dastarruer = let
      fish = config.programs.fish;
    in {
      programs.zellij = {
        enable = true;
        attachExistingSession = true;
        enableFishIntegration = fish.enable;
      };
    };
  };
}
