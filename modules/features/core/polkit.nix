{...}: {
  flake.nixosModules.core = {pkgs, ...}: {
    services.polkit = {
      enable = true;
      package = pkgs.polkit_gnome;
    };
  };
}
