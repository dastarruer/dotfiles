{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
    in {
      programs.waybar.enable = true;

      stylix.targets.waybar.enable = false;

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        # Start waybar
        "exec-once" = [
          "waybar &"
        ];
        # Start/stop waybar keybind
        bind = [
          "SUPER, W, exec, pidof waybar && pkill waybar || waybar &"
        ];
        # more hyprland stuff i dont understand
        layerrule = [
          "blur on, match:namespace waybar"
          "xray on, match:namespace waybar"
        ];
      };
    };
  };
}
