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
      hyprland = config.wayland.windowManager.hyprland;
      backup = config.services.restic;
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

      home-manager.services.backup.backupPaths = lib.mkIf backup.enable ["${config.home.homeDirectory}/Documents/vault"];

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        windowrule = [
          "workspace 10 silent, match:class obsidian"
        ];
      };
    };
  };
}
