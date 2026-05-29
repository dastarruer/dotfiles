{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.custom.wm.wm == "hyprland";
      launcher = config.custom.wm.launcher;
    in
      lib.mkIf (launcher == "rofi") {
        programs.rofi.plugins = with pkgs; [
          rofi-calc
        ];

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          bind = [
            {_args = ["SUPER + C" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofi} -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}'\" | wl-copy && notify-send -t 1000 \"Copied to clipboard\"")'')];}
          ];
        };
      };
  };
}
