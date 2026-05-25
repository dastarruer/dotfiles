{...}: {
  flake.nixosModules.wm = {...}: {
    home-manager.users.dastarruer = {
      services.awww.enable = true;
    };
  };
}
