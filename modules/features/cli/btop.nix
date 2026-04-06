{...}: {
  flake.nixosModules.cli_btop = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
      programs.btop.enable = true;

      programs.fish.shellAliases.b = lib.mkIf config.programs.fish.enable "btop";
    };
  };
}
