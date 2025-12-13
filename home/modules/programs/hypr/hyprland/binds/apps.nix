{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = let
      name = "apps";
    in [
      "SUPER, O, exec, ${pkgs.writeShellApplication {
        name = "${name}";
        text = ''
          todoist-electron &
          anki &
          spotify &
          flatpak run md.obsidian.Obsidian &
        '';
      }}/bin/${name}"
    ];
  };
}
