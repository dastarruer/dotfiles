{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
    ];

    settings = {
      "plugin:split-monitor-workspaces" = {
        keep_focused = true;
        enable_persistent_workspaces = false;
      };
    };
  };
}
