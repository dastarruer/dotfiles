{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hmConfig = config.home-manager.users.dastarruer;
      hyprland = hmConfig.wayland.windowManager.hyprland;
      launcher = config.custom.wm.launcher;
    in
      lib.mkIf (launcher == "rofi") {
        programs.rofi.plugins = with pkgs; [
          # Install it like this because wayland (https://discourse.nixos.org/t/rofi-calc-not-working-with-rofi-wayland/51301/2)
          (rofi-calc.override {rofi-unwrapped = rofi-unwrapped;})
        ];

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
          bind = [
            {_args = ["SUPER + C" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofi} -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}'\" | wl-copy && notify-send -t 1000 \"Copied to clipboard\"")'')];}
          ];
        };
      };
  };
}
