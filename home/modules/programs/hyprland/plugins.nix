{
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
  };
  home.file.".cache/hypr/load-plugins.conf".text = ''
    exec-once = hyprctl plugin load ${inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces}/lib/libsplit-monitor-workspaces.so;
  '';
}
