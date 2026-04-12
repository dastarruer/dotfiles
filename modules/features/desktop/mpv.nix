{...}: {
  flake.nixosModules.desktop_mpv = {...}: {
    home-manager.users.dastarruer = {
      programs.mpv.enable = true;
    };
  };
}
