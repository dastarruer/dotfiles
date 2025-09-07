{pkgs, ...}: {
  programs.rofi.plugins = with pkgs; [
    # Install it like this because wayland (https://discourse.nixos.org/t/rofi-calc-not-working-with-rofi-wayland/51301/2)
    (rofi-calc.override {rofi-unwrapped = rofi-wayland-unwrapped;})
  ];
}
