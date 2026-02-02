{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  options = {
    home-manager.desktop.obsidian.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable Obsidian, a notetaking app.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.obsidian.enable {
    # Use the flatpak, which does not ask for login every reboot
    services.flatpak = {
      packages = [
        "flathub:app/md.obsidian.Obsidian/x86_64/stable"
      ];

      # Enable wayland support for obsidian
      overrides."md.obsidian.Obsidian".Context.sockets = lib.mkIf hyprland.enable [
        "wayland"
        "!x11"
        "!fallback-x11"
      ];
    };

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      windowrule = [
        "workspace 10 silent, match:class obsidian"
      ];
    };
  };
}
