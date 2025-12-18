{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    "bind" = [
      # Custom scripts (defined in home/modules/scripts)
      "SUPER, O, exec, ${pkgs.apps}/bin/apps"
      "ALT, B, exec, ${pkgs.brightness}/bin/brightness + 5"
      "ALT, V, exec, ${pkgs.brightness}/bin/brightness - 5"
      "SUPER+SHIFT, W, exec, ${pkgs.change-wallpaper}/bin/change-wallpaper"
      "SUPER, B, exec, ${pkgs.headphones}/bin/headphones"
      "SUPER, P, exec, ${pkgs.kill-apps}/bin/kill-apps"
      "SUPER, K, exec, ${pkgs.move-windows-to-monitor}/bin/move-windows-to-monitor"
      "SUPER, Y, exec, ${pkgs.toggle-hdmi}/bin/toggle-HDMI-A-1"
      "SUPER+SHIFT, Y, exec, ${pkgs.toggle-laptop}/bin/toggle-eDP-1"
      "SUPER, E, exec, ${pkgs.power}/bin/power"
    ];
  };
}
