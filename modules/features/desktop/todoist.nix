{...}: {
  flake.nixosModules.desktop_todoist = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hmConfig = config.home-manager.users.dastarruer;
      hyprland = hmConfig.wayland.windowManager.hyprland;
    in {
      home.packages = [
        pkgs.todoist-electron
      ];

      wayland.windowManager.hyprland.settings.window_rule = lib.mkIf hyprland.enable [
        {
          match.class = "Todoist";
          workspace = "6 silent";
        }
      ];
    };
  };
}
