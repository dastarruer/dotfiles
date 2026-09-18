{...}: {
  flake.nixosModules.wm = {config, ...}: let
    screenshotPath = config.custom.wm.screenshot.path;
    hmConfig = config.home-manager.users.dastarruer;
    borderSize = hmConfig.wayland.windowManager.hyprland.settings.config.general.border_size;
  in {
    home-manager.users.dastarruer = {
      # Create the screenshots dir, deleting files older than 30 days
      systemd.user.tmpfiles.rules = [
        "d ${screenshotPath} - - - 30d -"
      ];

      home.sessionVariables.SLURP_ARGS = "-d -b ${config.lib.stylix.colors.base00}80 -B ${config.lib.stylix.colors.base05}4D -c ${config.custom.theme.accent} -w ${toString borderSize}";
    };
  };
}
