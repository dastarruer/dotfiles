{...}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 2;
      resize_on_border = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 5;
      rounding_power = 2;
      active_opacity = 0.8;
      inactive_opacity = 0.8;
      fullscreen_opacity = 1;
      dim_inactive = false;
      dim_strength = 0.05;
      shadow = {
        enabled = true;
        range = 5;
        render_power = 2;
        ignore_window = true;
      };
      blur = {
        enabled = true;
        size = 10;
        passes = 4;
        ignore_opacity = "on";
        popups = true;
        new_optimizations = true;
      };
    };

    animations = {
      enabled = true;
      animation = "workspaces, 3, 8, default, slidefade 50%";
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
  };
}
