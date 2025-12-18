{...}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 4;
      resize_on_border = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 0;
      rounding_power = 2;

      active_opacity = 1.0;
      inactive_opacity = 0.9;
      fullscreen_opacity = 1.0;
      dim_inactive = false;
      dim_strength = 0.05;

      shadow = {
        enabled = true;
        range = 35;
        render_power = 3;
        ignore_window = true;
        offset = "15 15";
      };

      blur = {
        enabled = true;
        size = 5;
        passes = 5;
        ignore_opacity = true;
        popups = true;
        new_optimizations = true;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "overshot, 0, 0.9, 0.1, 1.15"
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
      ];

      animation = [
        # Windows
        "windows, 1, 3, overshot, slide"
        "windowsOut, 1, 3, smoothOut, slide"
        "windowsMove, 1, 3, default"

        # Layers
        "layers, 1, 3, overshot, slide"
        "layersOut, 1, 3, smoothOut, slide"

        # Workspaces
        "workspaces, 1, 3, smoothIn"
        "specialWorkspace, 1, 3, overshot, slidevert"
        "specialWorkspaceOut, 1, 3, smoothIn, slidevert"

        # Other
        "border, 1, 3, default"
        "fade, 1, 3, smoothIn"
        "fadeDim, 1, 3, smoothIn"
      ];
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
  };
}
