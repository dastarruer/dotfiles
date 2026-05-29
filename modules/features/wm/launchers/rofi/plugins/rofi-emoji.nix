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
        programs.rofi.plugins = [
          pkgs.rofi-emoji
        ];

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          bind = [
            {_args = ["SUPER + A" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofi} -modi emoji -show emoji")'')];}
          ];
        };
      };
  };
}
