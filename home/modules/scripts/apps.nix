{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      apps = prev.writeShellApplication {
        name = "apps";
        text = ''
          todoist-electron &
          anki &
          spotify &
          flatpak run md.obsidian.Obsidian &
        '';
      };
    })
  ];
}
