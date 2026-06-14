{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    home-manager.users.dastarruer = lib.mkIf hyprland {
      stylix.targets.hyprland.enable = false;

      wayland.windowManager.hyprland.settings.config = {
        general = {
          "col.active_border" = "rgb(${config.custom.theme.accent})";
          # Make inactive border transparent
          "col.inactive_border" = "rgba(00000000)"; #"rgb(${config.lib.stylix.colors.base03})";
        };

        decoration = {
          shadow = {
            color = "rgb(${config.lib.stylix.colors.base00})";
          };
        };
      };
    };
  };
}
