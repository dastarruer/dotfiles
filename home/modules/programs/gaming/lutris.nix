{
  pkgs,
  lib,
  ...
}: {
  programs.lutris = {
    enable = true;

    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = with pkgs; [
      proton-ge-bin
    ];

    extraPackages = with pkgs; [
      gamescope
      gamemode
    ];

    runners.wine.settings.system = {
      # Enable gamescope. Pretty useful since it has a frame limiter, and
      # automatically adjusts the game resolution to meet said frame rate.
      gamescope = "true";
      gamescope_flags = lib.concatStringsSep " " [
        "--force-grab-cursor" # Forces the game to capture mouse movement, so camera movement is not restricted
        "--expose-wayland" # Wayland support
      ];

      # Set fps limit of 30
      gamescope_fps_limiter = "30";

      # Fullscreen game window
      gamescope_window_mode = "-f";
    };
  };
}
