{...}: {
  flake.nixosModules.core = {...}: {
    home-manager.users.dastarruer = {
      gtk.enable = true;
    };
  };
}
