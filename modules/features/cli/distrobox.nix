{...}: {
  flake.nixosModules.cli_distrobox = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
      programs.distrobox.enable = true;
    };
  };
}
