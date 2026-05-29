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
          # Media keybinds
          {
            _args = [
              "XF86AudioPlay"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.pause-all}")'')
            ];
          }
          {
            _args = [
              "SHIFT + XF86AudioPlay"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} play-pause -p spotify")'')
            ];
          }
          {
            _args = [
              "XF86AudioPrev"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} previous")'')
            ];
          }
          {
            _args = [
              "XF86AudioNext"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.playerctl} next")'')
            ];
          }
          # Audio keybinds
          {
            _args = [
              "XF86AudioRaiseVolume"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")'')
              {locked = true;}
            ];
          }
          {
            _args = [
              "XF86AudioLowerVolume"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
              {locked = true;}
            ];
          }
        ];
      };
    };
  };
}
