{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.window-manager.dunst.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable window-manager.dunst, a script to send notifications on low battery.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.dunst.enable {
    services.dunst = {
      enable = true;

      iconTheme = {
        # Dunst will share the same icon theme as gtk
        package = config.gtk.iconTheme.package;
        name = "${config.gtk.iconTheme.name}";
        size = "96x96";
      };

      # https://github.com/martin-djakovic/dotfiles/blob/main/.config/dunst/dunstrc
      settings = {
        global = {
          monitor = 0;
          follow = "none";
          width = 380;
          height = 200;
          origin = "top-right";
          offset = "5x5";
          scale = 0;
          notification_limit = 20;

          progress_bar = true;
          progress_bar_height = 9;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 400;
          progress_bar_corner_radius = 0;
          icon_corner_radius = 0;
          indicate_hidden = true;
          transparency = 0;
          separator_height = 3;
          padding = 8;
          horizontal_padding = 8;
          text_icon_padding = 0;
          frame_width = 1;
          frame_color = "#${config.lib.stylix.colors.base00}";
          gap_size = 5;
          separator_color = "frame";
          sort = true;

          font = "${config.stylix.fonts.sansSerif.name} ${toString config.stylix.fonts.sizes.applications}";
          markup = "full";
          format = "<b><span foreground='#${config.lib.stylix.colors.base09}'>%s</span></b>\n<span foreground='#${config.lib.stylix.colors.base05}'>%b</span>";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 60;
          ellipsize = "middle";
          ignore_newline = false;
          stack_duplicates = true;
          hide_duplicate_count = true;
          show_indicators = false;

          enable_recursive_icon_lookup = true;
          icon_theme = "Papirus-Dark";
          icon_position = "left";
          min_icon_size = 64;
          max_icon_size = 32;

          sticky_history = true;
          history_length = 20;

          browser = "/usr/bin/xdg-open";
          always_run_script = true;
          title = "Dunst";
          class = "Dunst";
          corner_radius = 0;
          ignore_dbusclose = false;
          force_xwayland = false;
          force_xinerama = false;

          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";

          highlight = "#${config.lib.stylix.colors.base09}";
          background = "#${config.lib.stylix.colors.base00}";
          foreground = "#${config.lib.stylix.colors.base05}";
        };

        experimental = {
          per_monitor_dpi = false;
        };

        urgency_low = {
          timeout = 10;
        };

        urgency_normal = {
          timeout = 10;
        };

        urgency_critical = {
          timeout = 0;
        };

        # Play an alert sound for all notifications: https://github.com/dunst-project/dunst/issues/257
        play_sound = let
          alertPath = ./alerts/default.wav;
        in {
          summary = "*";
          script = let
            name = "alert";
          in "${pkgs.writeShellApplication {
            name = "${name}";

            runtimeInputs = with pkgs; [
              pipewire
            ];

            text = ''
              # Only proceed if urgency is NOT LOW
              if [ "$DUNST_URGENCY" = "LOW" ]; then
                  exit 0
              fi

              if [ "$DUNST_APP_NAME" != "Spotify" ] && \
                 [ "$DUNST_APP_NAME" != "flameshot" ] && \
                 [[ "$DUNST_SUMMARY" != *"Wallpaper set to:"* ]]; then
                  # Only play if no pw-play process is currently running
                  if ! pgrep -x pw-play >/dev/null; then
                      pw-play ${alertPath} &
                  fi
              fi
            '';
          }}";
        };
      };
    };
  };
}
