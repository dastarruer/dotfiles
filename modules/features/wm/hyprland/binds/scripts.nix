{...}: {
  flake.nixosModules.wm = {
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
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
              "SUPER + SHIFT + M"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.move-windows-to-monitor}")'')
            ];
          }
          {
            _args = [
              "SUPER + E"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.power}")'')
            ];
          }
          # bindl (trigger on release)
          {
            _args = [
              "SUPER + Y"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.toggle-hdmi}")'')
              {locked = true;}
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Y"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.toggle-laptop}")'')
              {locked = true;}
            ];
          }
        ];
      };
    };
  };
}
