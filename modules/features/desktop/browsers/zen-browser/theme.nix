{inputs, ...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    profile = config.custom.desktop.browser.profile;
    browser = config.custom.desktop.browser.kind;
    colors = config.lib.stylix.colors;
  in
    lib.mkIf (browser == "zen-browser") {
      home-manager.users.dastarruer = {
        programs.zen-browser.profiles."${profile}" = {
          mods = [
            "1b88a6d1-d931-45e8-b6c3-bfdca2c7e9d6" # Remove Tab X
            "c01d3e22-1cee-45c1-a25e-53c0f180eea8" # Ghost tabs
            "e74cb40a-f3b8-445a-9826-1b1b6e41b846" # Custom ui font
            "642854b5-88b4-4c40-b256-e035532109df" # Transparent zen
          ];
          settings = {
            "theme.customui_font.default" = "monospace";

            "zen.widget.linux.transparency" = true;
            "mod.sameerasw.zen_bg_color_enabled" = true;
            "mod.sameerasw.zen_transparency_color" = colors.withHashtag.base00;
            "zen.view.grey-out-inactive-windows" = false;
          };
        };
      };
    };
}
