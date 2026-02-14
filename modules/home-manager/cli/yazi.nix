{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  options = {
    home-manager.cli.yazi.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.cli.enable;
      description = "Enable yazi, a terminal file browser.";
    };
  };

  config = lib.mkIf config.home-manager.cli.yazi.enable {
    programs.yazi = {
      enable = true;

      plugins = let
        plugins = pkgs.yaziPlugins;
      in {
        # Obviously only meant for wayland, so only enable if hyprland is enabled
        "wl-clipboard" = lib.mkIf hyprland.enable plugins.wl-clipboard;
      };

      keymap = {
        mgr.prepend_keymap =
          [
            {
              on = "<C-n>";
              run = ''shell -- ${pkgs.dragon-drop}/bin/dragon-drop -x -i -T "$1"'';
              desc = "Initiate drag and drop";
            }
            {
              on = "<C-f>";
              run = "cd ${config.home.homeDirectory}/Documents/school/G10";
              desc = "Change to schoolwork dir";
            }
          ]
          ++ lib.optional hyprland.enable {
            # Removed the [ ] from around this block
            on = "<C-y>";
            run = ["plugin wl-clipboard"];
            desc = "Copy file to to system clipboard";
          };
      };
    };
  };
}
