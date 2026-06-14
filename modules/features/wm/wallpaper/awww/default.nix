{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    wallpaper-daemon = config.custom.wm.wallpaper-daemon;
  in lib.mkIf (wallpaper-daemon == "awww") {
    assertions = [
      {
        assertion = wayland;
        message = "awww only works on Wayland compositors.";
      }
    ];

    home-manager.users.dastarruer = {
      services.awww.enable = true;
    };
  };
}
