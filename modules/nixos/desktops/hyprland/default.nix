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

    # Required, since this is the default terminal when booting into hyprland for the first time.
    # Otherwise, good luck trying to get a terminal running
    kitty
  ];

  # Use hyprland cachix to avoid building hyprland from source.
  # Only needed if flake package is being used
  # https://wiki.land/Nix/Cachix/
  nix.settings = {
    extra-substituters = [
      "https://hyprland.cachix.org"
    ];
    extra-trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
