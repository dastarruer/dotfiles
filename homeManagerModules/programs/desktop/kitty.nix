{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.kitty.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.desktop.enableAll;
      description = "Enable kitty, a terminal emulator.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.kitty.enable {
    programs.kitty = {
      enable = true;

      settings = {
        # Cursor settings
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
        cursor_beam_thickness = "2.5";
        cursor_shape = "block";

        # Tab styling
        tab_bar_min_tabs = 1;
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

        # Other
        detect_urls = "yes";
        window_padding_width = 20;
        disable_ligatures = "always";
        text_composition_strategy = "legacy";
        confirm_os_window_close = 0;
      };
    };

    # Set hyprland keybind
    wayland.windowManager.hyprland.settings.bind = [
      "SUPER, RETURN, exec, kitty"
    ];
  };
}
