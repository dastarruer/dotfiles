{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
    in {
      services.swww.enable = true;

      # Start swww daemon on startup
      wayland.windowManager.hyprland.settings."exec-once" = lib.mkIf hyprland.enable [
        "swww-daemon &"
      ];
    };
  };
}
