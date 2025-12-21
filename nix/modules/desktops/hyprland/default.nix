{pkgs, ...}: {
  programs.uwsm.enable = true;

  # Reduce rebuild times by using prebuilt hyprland binaries rather than building from source (https://wiki.hypr.land/Nix/Cachix/)
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

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
