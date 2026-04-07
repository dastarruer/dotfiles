{...}: {
  flake.nixosModules.core = {...}: {
    home-manager.users.dastarruer = {
      qt.enable = true;
    };
  };
}
