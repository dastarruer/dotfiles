{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "bind" = [
      # Media keybinds
      ",XF86AudioPlay, exec, playerctl play-pause -p spotify"
      "SHIFT,XF86AudioPlay, exec, ${pkgs.pause-all}/bin/pause-all"
      ",XF86AudioPrev, exec, playerctl previous"
      ",XF86AudioNext, exec, playerctl next"
    ];

    # Audio keybinds
    "bindel" = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
  };
}
