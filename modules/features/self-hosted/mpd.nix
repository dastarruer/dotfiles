{...}: {
  flake.nixosModules.self-hosted_mpd = {
    config,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    musicPath = "${hmConfig.home.homeDirectory}/Music/mpd";
    backup = config.custom.backup;
  in {
    custom.backup.backupPaths = lib.mkIf backup.enable [
      musicPath
      hmConfig.services.mpd.playlistDirectory
    ];

    home-manager.users.dastarruer = {
      systemd.user.tmpfiles.rules = [
        "d ${musicPath} - - - - -"
      ];

      services.mpd-mpris.enable = true;
      services.mpd = {
        enable = true;
        musicDirectory = musicPath;
        network.startWhenNeeded = true; # only start MPD service upon connection to its socket
      };

      # im not remembering the full name it's just a bunch of letters
      programs.fish.shellAliases.nm = "${lib.getExe hmConfig.programs.ncmpcpp.package}";
      programs.ncmpcpp = {
        enable = true;
        settings = {
          # Layout and display
          user_interface = "alternative";
          playlist_display_mode = "columns";
          browser_display_mode = "columns";
          display_remaining_time = "yes";
          display_bitrate = "yes";
          header_visibility = "yes";
          statusbar_visibility = "yes";

          # Cursor and navigation
          autocenter_mode = "yes";
          centered_cursor = "yes";
          incremental_seeking = "yes";
          seek_time = "5";
          mouse_support = "yes";

          # Library behavior
          ignore_leading_the = "yes";
          playlist_disable_highlight_delay = "0";
          show_hidden_files_in_local_browser = "no";

          # Window title (off, so it doesn't fight with your WM)
          enable_window_title = "no";
        };

        bindings = [
          # Vertical movement (j/k are already defaults, listed for clarity)
          {
            key = "j";
            command = "scroll_down";
          }
          {
            key = "k";
            command = "scroll_up";
          }
          {
            key = "ctrl-d";
            command = "page_down";
          }
          {
            key = "ctrl-u";
            command = "page_up";
          }
          {
            key = "g";
            command = "move_home";
          }
          {
            key = "G";
            command = "move_end";
          }

          # Horizontal movement between panes
          {
            key = "h";
            command = "previous_column";
          }
          {
            key = "l";
            command = "next_column";
          }

          # Enter and leave
          {
            key = "ctrl-f";
            command = "page_down";
          }
          {
            key = "ctrl-b";
            command = "page_up";
          }

          # Searching
          {
            key = "/";
            command = "find";
          }
          {
            key = "n";
            command = "next_found_item";
          }
          {
            key = "N";
            command = "previous_found_item";
          }
        ];
      };
    };
  };
}
