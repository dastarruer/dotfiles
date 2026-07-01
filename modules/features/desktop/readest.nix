{...}: {
  flake.nixosModules.desktop_readest = {pkgs, ...}: {
    home-manager.users.dastarruer = {
      home.packages = [
        pkgs.readest
      ];
    };
  };
}
