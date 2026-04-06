{...}: {
  flake.nixosModules.shell_starship = {config, ...}: {
    home-manager.users.dastarruer = let
      fish = config.programs.fish;
    in {
      programs.starship = {
        enable = true;

        # These two features only work with the fish shell
        enableFishIntegration = fish.enable;
        enableTransience = fish.enable;
      };
    };
  };
}
