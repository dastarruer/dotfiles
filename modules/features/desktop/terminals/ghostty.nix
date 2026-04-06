{...}: {
  flake.nixosModules.desktop_terminal = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.programs.hyprland;
      terminal = config.custom.terminal;

      # Get cursor trails like in kitty
      cursor-trail-shader-path = "${pkgs.fetchFromGitHub {
        owner = "sahaj-b";
        repo = "ghostty-cursor-shaders";
        rev = "4faa83e4b9306750fc8de64b38c6f53c57862db8";
        hash = "sha256-ruhEqXnWRCYdX5mRczpY3rj1DTdxyY3BoN9pdlDOKrE=";
      }}/cursor_tail.glsl";
    in {
      programs.ghostty = lib.mkIf (terminal == "ghostty") {
        enable = true;
        enableFishIntegration = true;
        systemd.enable = true;

        settings = {
          cursor-style = "block";
          cursor-style-blink = false;
          link-url = true;
          window-padding-x = 20;
          window-padding-y = 20;

          # Disable ligatures
          font-feature = [
            "-calt"
            "-liga"
            "-dliga"
          ];

          keybind = [
            # Remove fullscreen keybind
            "ctrl+enter=unbind"
          ];

          # Don't ask before closing
          confirm-close-surface = false;

          # Send notification when command finished and terminal is unfocused
          notify-on-command-finish = "unfocused";
          notify-on-command-finish-action = "no-bell,notify";
          notify-on-command-finish-after = "15s";

          # Always keep ghostty systemd service running for fast window creation
          quit-after-last-window-closed = false;

          # Never show window size when resizing
          resize-overlay = "never";

          custom-shader = cursor-trail-shader-path;
          custom-shader-animation = "always"; # Otherwise, the cursor can pause while it is being animated if the terminal becomes unfocused

          cursor-click-to-move = true;
          mouse-hide-while-typing = true;
        };
      };

      wayland.windowManager.hyprland.settings.bind = lib.mkIf hyprland.enable [
        "SUPER, RETURN, exec, ghostty +new-window"
      ];
    };
  };
}
