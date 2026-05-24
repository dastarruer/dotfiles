{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = hmConfig.wayland.windowManager.hyprland;
  in {
    home-manager.users.dastarruer = {
      services.hyprsunset = {
        enable = true;

        extraArgs = [
          # Change temperature to a slightly warmer 5500K
          "-t"
          "5500"
        ];
      };
    };
  };
}
