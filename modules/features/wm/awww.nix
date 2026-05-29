{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
  in {
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
