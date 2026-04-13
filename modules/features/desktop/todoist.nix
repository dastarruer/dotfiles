{...}: {
  flake.nixosModules.desktop_todoist = {pkgs, ...}: {
    home-manager.users.dastarruer = {
        home.packages = [
            pkgs.todoist-electron
        ];
    };
  };
}
