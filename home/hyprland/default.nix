{...}: {
  imports = [
    ./source
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
