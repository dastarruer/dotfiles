{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;

    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;
    clipboard = config.custom.wm.clipboard;
    launcher = config.custom.wm.launcher;

    hyprland = config.custom.wm.wm == "hyprland";
  in
    lib.mkIf (clipboard == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
        {
          assertion = bar == "noctalia";
          message = "noctalia clipboard only works after enabling the noctalia bar.";
        }
        {
          assertion = launcher == "noctalia";
          message = "noctalia clipboard only works with the noctalia launcher.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.noctalia.settings.shell = {
          clipboard_enabled = true;
          clipboard_auto_paste  = "off";
          clipboard_confirm_clear_history = false;
        };
        
        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          bind = [
            # Clipboard
            {_args = ["SUPER + V" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe hmConfig.programs.noctalia.package} msg panel-toggle clipboard && notify-send -t 1000 \"Copied to clipboard\"")'')];}
          ];
        };
      };
    };
}
