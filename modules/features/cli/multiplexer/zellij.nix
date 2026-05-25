{...}: {
  flake.nixosModules.cli_multiplexer = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      fish = config.programs.fish;
      multiplexer = config.custom.cli.multiplexer;
    in {
      programs.zellij = lib.mkIf (multiplexer == "zed") {
        enable = true;
        attachExistingSession = true;
        enableFishIntegration = fish.enable;
      };
    };
  };
}
