{...}: {
  flake.nixosModules.wm = {
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings = {
        on = [
          {
            # Move windows to monitor when new monitor is added
            _args = [
              "monitor.added"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("${lib.getExe pkgs.move-windows-to-monitor}")
                end'')
            ];
          }
        ];
      };
    };
  };
}
