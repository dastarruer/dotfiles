{pkgs, ...}: {
  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Start hyprland on boot
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    # clipboard functionality
    wl-clipboard
  ];
}
