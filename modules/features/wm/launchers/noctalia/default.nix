{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;

    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;
    launcher = config.custom.wm.launcher;

    hyprland = config.custom.wm.wm == "hyprland";

    gtkshutdown = inputs.gtkshutdown.packages.${pkgs.stdenv.system}.default;
    shutdownCmd = "RUST_LOG=trace ${lib.getExe gtkshutdown} --post-cmd 'reboot'";
  in
    lib.mkIf (launcher == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
        {
          assertion = bar == "noctalia";
          message = "noctalia launcher only works after enabling the noctalia bar.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.noctalia.settings = {
          shell.panel.launcher_placement = "attached";

          # Since gtkshutdown only works on hyprland rn
          # hooks = lib.mkIf hyprland {
          #   rebooting = shutdownCmd;
          #   shutting_down = shutdownCmd;
          # };
        };

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          bind = [
            # Launcher
            {_args = ["SUPER + D" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe hmConfig.programs.noctalia.package} msg panel-toggle launcher")'')];}

            # Emoji
            {_args = ["SUPER + A" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe hmConfig.programs.noctalia.package} msg panel-toggle launcher \"/emo\"")'')];}
          ];
        };
      };
    };
}
