{...}: {
  imports = [
    ../../pulseaudio.nix
  ];

  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Start hyprland on boot
    withUWSM = true;
  };
}
