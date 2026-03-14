{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Media keybinds
      ",XF86AudioPlay, exec, ${lib.getExe pkgs.pause-all}"
      "SHIFT,XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause -p spotify"
      ",XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
      ",XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
    ];

    # Audio keybinds
    bindel = [
      ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
  };
}
