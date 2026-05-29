{...}: {
  flake.nixosModules.desktop_todoist = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.custom.wm.wm == "hyprland";
    in {
      home.packages = [
        pkgs.todoist-electron
      ];

      wayland.windowManager.hyprland.settings.window_rule = lib.mkIf hyprland [
        {
          match.class = "Todoist";
          workspace = "6 silent";
        }
      ];
    };
  };
}
