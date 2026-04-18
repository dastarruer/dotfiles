{...}: {
  flake.nixosModules.services_cliphist = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = hmConfig.wayland.windowManager.hyprland;
    rofi = hmConfig.programs.rofi;
  in {
    home-manager.users.dastarruer = {
      services.cliphist = {
        enable = true;
      };

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        bind = lib.mkIf rofi.enable [
          "SUPER, V, exec, ${lib.getExe pkgs.cliphist} list | ${lib.getExe pkgs.rofi} -dmenu | ${lib.getExe pkgs.cliphist} decode | ${pkgs.wl-clipboard}/bin/wl-copy"
        ];
      };
    };
  };
}
