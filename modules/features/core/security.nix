{...}: {
  flake.nixosModules.core = {...}: {
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    home-manager.users.dastarruer = {
      services.polkit-gnome.enable = true;
    };
  };
}
