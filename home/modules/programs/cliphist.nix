{pkgs, ...}: {
  home.packages = with pkgs; [
    cliphist
  ];

  wayland.windowManager.hyprland.settings = {
    "exec-once" = [
      # Start clipboard manager
      "wl-paste --type text --watch cliphist store &"
      "wl-paste --type image --watch cliphist store &"
    ];
  };
}
