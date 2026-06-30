{inputs, ...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
    browser = config.custom.desktop.browser.kind;
  in
    lib.mkIf (browser == "zen-browser") {
      home-manager.users.dastarruer = {
        imports = [
          inputs.zen-browser.homeModules.beta
        ];

        # Stylix theme sucks
        stylix.targets.zen-browser.enable = false;

        programs.zen-browser = {
          enable = true;
          setAsDefaultBrowser = true;
        };

        # Windowrules for picture-in-picture
        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          window_rule = [
            {
              match.title = "Picture-in-Picture";
              float = true;
              move = lib.generators.mkLuaInline "{3408, 834}";
              size = lib.generators.mkLuaInline "{427, 240}";
              pin = true;
            }
          ];
        };
      };
    };
}
