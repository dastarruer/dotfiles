{...}: {
  services.flatpak = {
    packages = [
      "flathub:app/md.obsidian.Obsidian/x86_64/stable"
    ];

    # Enable wayland support for obsidian
    overrides."md.obsidian.Obsidian".sockets = {
      "wayland" = true;
      "x11" = false;
      "fallback-x11" = false;
    };
  };
}
