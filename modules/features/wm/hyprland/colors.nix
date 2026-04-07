{...}: {
  flake.nixosModules.wm = {config, ...}: {
    home-manager.users.dastarruer = {
      stylix.targets.hyprland.enable = false;

      wayland.windowManager.hyprland.settings = {
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
