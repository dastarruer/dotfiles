{...}: {
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
}
