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
      programs.waybar = {
        enable = true;
        systemd.enable = true;
      };

      stylix.targets.waybar.enable = false;

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        # Start/stop waybar keybind
        bind = [
          {_args = ["SUPER + W" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pidof waybar && pkill waybar || waybar &")'')];}
        ];
        # more hyprland stuff i dont understand
        layer_rule = [
          {
            match.namespace = "waybar";
            blur = true;
            xray = true;
          }
        ];
      };
    };
  };
}
