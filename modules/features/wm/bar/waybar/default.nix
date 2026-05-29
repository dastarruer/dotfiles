{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar;
  in
    lib.mkIf (bar == "waybar") {
      assertions = [
        {
          assertion = wayland;
          message = "waybar is only compatible with Wayland compositors.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.waybar = {
          enable = true;
          package = inputs.waybar.packages.${pkgs.stdenv.system}.waybar;
          systemd.enable = true;
        };

        stylix.targets.waybar.enable = false;

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          # Start/stop waybar keybind
          bind = [
            {_args = ["SUPER + W" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pidof waybar && pkill waybar || waybar &")'')];}
          ];
          # more hyprland stuff i dont understand
          layer_rule = [
            {
              match.namespace = "waybar";
              blur = true;
              xray = true;
            }
          ];
        };
      };
    };
}
