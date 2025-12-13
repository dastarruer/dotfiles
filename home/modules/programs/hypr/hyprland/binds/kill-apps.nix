{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = let
      name = "kill_apps";
    in [
      "SUPER, P, exec, ${pkgs.writeShellApplication {
        name = "${name}";
        text = ''
          pkill -f todoist
          pkill -f anki
          pkill -f spotify
          pkill -f obsidian
          # Kill without cleanup
          pkill -9 codium
        '';
      }}/bin/${name}"
    ];
  };
}
