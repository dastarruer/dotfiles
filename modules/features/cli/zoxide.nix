{...}: {
  flake.nixosModules.cli_zoxide = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      fish = config.programs.fish;
    in {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = fish.enable;
      };

      programs.fish.shellAliases.".." = lib.mkIf fish.enable "z ..";
    };
  };
}
