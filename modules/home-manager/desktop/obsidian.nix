{
  config,
  lib,
  ...
}: let
  hyprland = config.home-manager.window-manager.hyprland;
  backup = config.home-manager.services.backup;
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

    # my notes are NOT going on the cloud. god know what they'll find in there...
    services.restic.backups.drive.exclude = ["${config.home.homeDirectory}/Documents/vault"];
    home-manager.services.backup.backupPaths = ["${config.home.homeDirectory}/Documents/vault"];

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      windowrule = [
        "workspace 10 silent, match:class obsidian"
      ];
    };
  };
}
