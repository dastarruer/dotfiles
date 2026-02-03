{...}: {
  wayland.windowManager.hyprland.settings = {
    general.layout = "dwindle";

    # Always split windows to the right
    dwindle.force_split = "2";
  };
}
