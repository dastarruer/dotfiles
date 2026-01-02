{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    dotfiles.desktop.gaming.lutris.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.desktop.gaming.enable;
      description = "Enable lutris, a game launcher.";
    };
  };

  config = lib.mkIf config.dotfiles.lutris.enable {
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

      runners.wine.settings = {
        system = {
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

          # Max fsr sharpness (0-20, where 0 is max and 20 is min)
          gamescope_fsr_sharpness = "0";

          # Set game to 720p
          gamescope_game_res = "1280x720";

          # Upscale game to my 1080p monitor
          gamescope_output_res = "1920x1080";
        };

        runner = {
          # Enable controller support
          autoconf_joypad = true;
        };
      };
    };
  };
}
