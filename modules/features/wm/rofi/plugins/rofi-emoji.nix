{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hmConfig = config.home-manager.users.dastarruer;
      hyprland = hmConfig.wayland.windowManager.hyprland;
    in {
      programs.rofi.plugins = [
        pkgs.rofi-emoji
      ];

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        bind = [
          "SUPER, A, exec, rofi -modi emoji -show emoji"
        ];
      };
    };
  };
}
