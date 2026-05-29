{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    home-manager.users.dastarruer = lib.mkIf hyprland {
      wayland.windowManager.hyprland.settings = {
        bind = [
          # Custom scripts (defined in home/modules/scripts)
          {
            _args = [
              "ALT + B"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.brightness} + 5")'')
            ];
          }
          {
            _args = [
              "ALT + V"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.brightness} - 5")'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + W"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.change-wallpaper}")'')
            ];
          }
          {
            _args = [
              "SUPER + B"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.headphones}")'')
            ];
          }
          {
            _args = [
              "SUPER + E"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.power}")'')
            ];
          }
          {
            _args = [
              "SUPER + Y"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.toggle-focused-monitor}")'')
              {locked = true;}
            ];
          }
        ];
      };
    };
  };
}
