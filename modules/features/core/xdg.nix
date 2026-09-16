{...}: {
  flake.nixosModules.core = {...}: {
    home-manager.users.dastarruer = {
      xdg.mimeApps.enable = true;
    };
  };
}
