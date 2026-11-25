{...}: {
  flake.nixosModules.desktop_minuet = {pkgs, ...}: {
    home-manager.users.dastarruer = {
      home.packages = [pkgs.kdePackages.minuet];
    };
  };
}
