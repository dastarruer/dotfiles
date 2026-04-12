{self, ...}: {
  flake.nixosModules.desktop_obsidian = {
    config,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.flatpak
    ];

    home-manager.users.dastarruer = let
      hmConfig = config.home-manager.users.dastarruer;
      hyprland = hmConfig.wayland.windowManager.hyprland;
      backup = config.custom.backup;
    in {
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

      custom.backup.backupPaths = lib.mkIf backup.enable ["${config.home-manager.users.dastarruer.home.homeDirectory}/Documents/vault"];

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        windowrule = [
          "workspace 10 silent, match:class obsidian"
        ];
      };
    };
  };
}
