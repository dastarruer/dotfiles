{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      "col.active_border" = "rgb(${config.lib.stylix.colors.base05})";
      "col.inactive_border" = "rgba(00000000)"; #"rgb(${config.lib.stylix.colors.base03})";
    };

    decoration = {
      shadow = {
        color = "rgb(${config.lib.stylix.colors.base00})";
      };
    };
  };
}
