{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.obsidian.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Obsidian, a notetaking app.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.obsidian.enable {
    # Use the flatpak, which does not ask for login every reboot
    services.flatpak = {
      packages = [
        "flathub:app/md.obsidian.Obsidian/x86_64/stable"
      ];

      # Enable wayland support for obsidian
      overrides."md.obsidian.Obsidian".sockets = [
        "wayland"
        "!x11"
        "!fallback-x11"
      ];
    };

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "workspace 10 silent,class:^(obsidian)$"
      ];
    };
  };
}
