{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
    in {
      services.awww.enable = true;

      # Start awww daemon on startup
      wayland.windowManager.hyprland.settings."exec-once" = lib.mkIf hyprland.enable [
        "awww-daemon &"
      ];
    };
  };
}
