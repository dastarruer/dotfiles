{...}: {
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, waybar"
      "xray 0, waybar"
      "ignorezero, waybar"
      "blur, rofi"
      "xray 0, rofi"
      "ignorezero, rofi"
    ];
  };
}
