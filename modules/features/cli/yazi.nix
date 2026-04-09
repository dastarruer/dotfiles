{...}: {
  flake.nixosModules.cli_yazi = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      fish = config.programs.fish;
      hyprland = config.wayland.windowManager.hyprland;
    in {
      programs.yazi = {
        enable = true;
        enableFishIntegration = fish.enable;
        shellWrapperName = "y";

        # Obviously only meant for wayland, so only enable if hyprland is enabled
        plugins."wl-clipboard" = let
          plugins = pkgs.yaziPlugins;
        in
          lib.mkIf hyprland.enable plugins.wl-clipboard;

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
              on = "<C-y>";
              run = ["plugin wl-clipboard"];
              desc = "Copy file to to system clipboard";
            };
        };
      };

      # I think this is default behavior, but just in case...
      programs.fish.shellAliases.y = lib.mkIf fish.enable "yazi";
    };
  };
}
