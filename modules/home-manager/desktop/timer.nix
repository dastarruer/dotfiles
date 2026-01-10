{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.desktop.timer.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable a timer app.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.timer.enable {
    services.flatpak = {
      packages = [
        "flathub:app/com.github.vikdevelop.timer/x86_64/stable"
      ];
    };
  };
}
