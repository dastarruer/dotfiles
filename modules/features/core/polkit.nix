{...}: {
  flake.nixosModules.core = {...}: {
    security.polkit.enable = true;

    home-manager.users.dastarruer = {
      services.polkit-gnome.enable = true;
    };
  };
}
