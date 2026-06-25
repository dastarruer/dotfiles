{...}: {
  flake.nixosModules.desktop_bottles = {pkgs,...}: {
    home-manager.users.dastarruer = {
      home.packages = [pkgs.bottles];
    };
  };
}
