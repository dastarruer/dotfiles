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

      wayland.windowManager.hyprland.settings."exec-once" = lib.mkIf hyprland.enable [
        # For some reason, the systemd hyprsunset service does not start properly on startup. This is a workaround
        "${pkgs.systemd}/bin/systemctl --user start hyprsunset.service"
      ];
    };
  };
}
