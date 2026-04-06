{...}: {
  flake.nixosModules.cli_distrobox = {...}: {
    home-manager.users.dastarruer = {
      programs.distrobox.enable = true;
    };
  };
}
