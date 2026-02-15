{
  lib,
  config,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hyprland;
in {
  options = {
    home-manager.desktop.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable OBS, a screen recording app.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.obs.enable {
    programs.obs-studio.enable = true;

    # Create the save dir for obs
    systemd.user.tmpfiles.rules = [
      "d %h/Videos/screen-recordings - - - - -"
    ];

    # Let obs capture screen
    wayland.windowManager.hyprland.settings.permission = lib.mkIf hyprland.enable [
      "${pkgs.obs-studio}/bin/obs, screencopy, allow"
    ];
  };
}
