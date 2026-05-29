{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    scrolling = config.custom.wm.scrolling;
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    home-manager.users.dastarruer = lib.mkIf hyprland {
      wayland.windowManager.hyprland.settings = {
        bind =
          [
            {
              _args = ["SUPER + Q" (lib.generators.mkLuaInline ''hl.dsp.window.close()'')];
            }
            {
              _args = ["SUPER + Space" (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')];
            }
            {
              _args = ["SUPER + G" (lib.generators.mkLuaInline ''hl.dsp.window.center()'')];
            }
            {
              _args = ["SUPER + F" (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen()'')];
            }
            {
              _args = ["SUPER + SHIFT + A" (lib.generators.mkLuaInline ''hl.dsp.window.pin()'')];
            }
          ]
          # Scrollable tiling binds
          ++ lib.optionals scrolling.enable [
            {
              _args = ["SUPER + H" (lib.generators.mkLuaInline ''hl.dsp.layout("focus l")'')];
            }
            {
              _args = ["SUPER + L" (lib.generators.mkLuaInline ''hl.dsp.layout("focus r")'')];
            }
            {
              _args = ["SUPER + J" (lib.generators.mkLuaInline ''hl.dsp.layout("focus u")'')];
            }
            {
              _args = ["SUPER + K" (lib.generators.mkLuaInline ''hl.dsp.layout("focus d")'')];
            }
            {
              _args = ["SUPER + SHIFT + H" (lib.generators.mkLuaInline ''hl.dsp.layout("swapcol l")'')];
            }
            {
              _args = ["SUPER + SHIFT + L" (lib.generators.mkLuaInline ''hl.dsp.layout("swapcol r")'')];
            }
            {
              _args = ["SUPER + CONTROL + H" (lib.generators.mkLuaInline ''hl.dsp.layout("colresize -0.1")'')];
            }
            {
              _args = ["SUPER + CONTROL + L" (lib.generators.mkLuaInline ''hl.dsp.layout("colresize +0.1")'')];
            }
          ]
          # Dwindle tiling binds
          ++ lib.optionals (!scrolling.enable) [
            {
              _args = ["SUPER + H" (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "l" })'')];
            }
            {
              _args = ["SUPER + L" (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "r" })'')];
            }
            {
              _args = ["SUPER + J" (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "u" })'')];
            }
            {
              _args = ["SUPER + K" (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "d" })'')];
            }
            {
              _args = ["SUPER + SHIFT + H" (lib.generators.mkLuaInline ''hl.dsp.window.swap({ direction = "l" })'')];
            }
            {
              _args = ["SUPER + SHIFT + L" (lib.generators.mkLuaInline ''hl.dsp.window.swap({ direction = "r" })'')];
            }
            {
              _args = ["SUPER + SHIFT + K" (lib.generators.mkLuaInline ''hl.dsp.window.swap({ direction = "u" })'')];
            }
            {
              _args = ["SUPER + SHIFT + J" (lib.generators.mkLuaInline ''hl.dsp.window.swap({ direction = "d" })'')];
            }
            {
              _args = ["SUPER + CONTROL + H" (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = -50, y = 0, relative = true })'')];
            }
            {
              _args = ["SUPER + CONTROL + L" (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 50, y = 0, relative = true })'')];
            }
            {
              _args = ["SUPER + CONTROL + K" (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 0, y = -50, relative = true })'')];
            }
            {
              _args = ["SUPER + CONTROL + J" (lib.generators.mkLuaInline ''hl.dsp.window.resize({ x = 0, y = 50, relative = true })'')];
            }
          ];
      };
    };
  };
}
