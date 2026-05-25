{...}: {
  flake.nixosModules.wm = {...}: {
    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings = {
        config = {
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;

            middle_click_paste = false;

            # Allows to restart lockscreen if it crashes
            allow_session_lock_restore = true;
          };

          binds = {
            # If I have a pinned picture-in-picture window, it will stay pinned even after fullscreening it
            allow_pin_fullscreen = true;
          };

          ecosystem = {
            # no i cant donate sorry
            no_donation_nag = true;

            # enable hyprland's new permission system
            enforce_permissions = true;
          };

          general = {
            # Resize windows by dragging borders
            resize_on_border = true;
          };
        };

        # Monitor setup
        monitor = [
          # Main monitor in middle
          {
            output = "DP-1";
            mode = "1920x1080@144";
            position = "0x0";
            scale = 1;
          }

          # Laptop monitor on the right
          {
            output = "eDP-1";
            mode = "1920x1080@60";
            position = "1920x0";
            scale = 1;
          }
        ];

        env = [
          {_args = ["XCURSOR_SIZE" "24"];}
          {_args = ["HYPRCURSOR_SIZE" "24"];}
        ];
      };
    };
  };
}
