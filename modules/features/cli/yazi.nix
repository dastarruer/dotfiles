{...}: {
  flake.nixosModules.cli_yazi = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      fish = config.programs.fish;
      wayland = config.custom.wm.wayland;
    in {
      programs.yazi = {
        enable = true;
        enableFishIntegration = fish.enable;
        shellWrapperName = "y";

        keymap = {
          mgr.prepend_keymap =
            [
              {
                on = "<C-n>";
                run = "shell -- ${lib.getExe pkgs.dragon-drop} -x -i -T %h";
                desc = "Initiate drag and drop";
              }
              {
                on = "<C-f>";
                run = "cd ${config.home-manager.users.dastarruer.home.homeDirectory}/Documents/school/G11";
                desc = "Change to schoolwork dir";
              }
            ]
            # https://yazi-rs.github.io/docs/tips#selected-files-to-clipboard
            ++ lib.optional wayland {
              on = "y";
              run = [''shell -- for path in %s; do echo "file://$path"; done | wl-copy -t text/uri-list'' "yank"];
              desc = "Yank and copy file to to system clipboard";
            };
        };
      };

      # I think this is default behavior, but just in case...
      programs.fish.shellAliases.y = lib.mkIf fish.enable "yazi";
    };
  };
}
