{pkgs, ...}: {
  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Start hyprland on boot
    withUWSM = true;
  };

  # Lockscreen
  programs.hyprlock.enable = true;

  # For stuff between apps like clipboard access, drag and drop, etc.
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
