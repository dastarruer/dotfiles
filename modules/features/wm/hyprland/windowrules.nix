{...}: {
  flake.nixosModules.wm = {...}: {
    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings = {
        # Window rules
        window_rule = [
          # Opacity overrides
          {
            match.class = "firefox|thunar|firefox-nightly";
            opacity = "1.0 override";
          }
          # Suppress maximize for all windows
          {
            match.class = ".*";
            suppress_event = "maximize";
          }
          # No initial focus for unidentified xwayland floating windows
          {
            match = {
              class = "^$";
              title = "^$";
              xwayland = true;
              float = true;
              fullscreen = false;
              pin = false;
            };
            no_initial_focus = true;
          }
          # No shadows on tiled windows
          {
            match.float = false;
            no_shadow = true;
          }
          # Idle inhibit
          {
            match.class = ".*";
            idle_inhibit = "fullscreen";
          }
          {
            match.title = ".*";
            idle_inhibit = "fullscreen";
          }
          {
            match.fullscreen = true;
            idle_inhibit = "fullscreen";
          }
        ];
      };
    };
  };
}
