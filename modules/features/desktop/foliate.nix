{...}: {
  flake.nixosModules.desktop_foliate = {...}: {
    home-manager.users.dastarruer = {
      programs.foliate.enable = true;
    };
  };
}
