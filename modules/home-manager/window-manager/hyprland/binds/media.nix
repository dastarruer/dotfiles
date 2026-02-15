{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Media keybinds
      ",XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause -p spotify"
      "SHIFT,XF86AudioPlay, exec, ${pkgs.pause-all}/bin/pause-all"
      ",XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
      ",XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
    ];

    # Audio keybinds
    bindel = [
      ",XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
  };
}
