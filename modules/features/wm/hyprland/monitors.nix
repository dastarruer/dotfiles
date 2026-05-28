{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings = {
        # Monitor setup
        monitor =
          map (
            m: let
              res =
                if m.resolution != null
                then "${toString m.resolution.width}x${toString m.resolution.height}@${toString m.resolution.rate}"
                else "preferred";
            in {
              output = m.name;
              mode = res;
              position = "${toString m.position.x}x${toString m.position.y}";
              scale = m.scale;
            }
          )
          config.custom.wm.monitors;

        # Set each workspace to each monitor
        workspace_rule =
          lib.concatMap (
            monitor:
              map (workspace: {
                workspace = toString workspace;
                monitor = monitor.name;
              })
              monitor.workspaces
          )
          config.custom.wm.monitors;
      };
    };
  };
}
