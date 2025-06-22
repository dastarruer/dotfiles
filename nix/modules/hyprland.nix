{pkgs, ...}: {
  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Start hyprland on boot
    withUWSM = true;
  };

  # For stuff between apps like clipboard access, drag and drop, etc.
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Enable sound with pipewire, which is better for wayland
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Hyprland packages needed
  environment.systemPackages = with pkgs; [
    waybar
    dunst
    rofi-wayland
    swww # Wallpaper daemon (might switch to hyprpaper later)
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts._3270
    nerd-fonts.jetbrains-mono
    fira-code
  ];
}
