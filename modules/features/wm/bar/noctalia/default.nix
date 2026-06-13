{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar;
  in
    lib.mkIf (bar == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
      ];

      home-manager.users.dastarruer = {
        imports = [
          inputs.noctalia.homeModules.default
        ];

        nix.settings = {
          extra-substituters = ["https://noctalia.cachix.org"];
          extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
        };

        home-manager.users.dastarruer = {
          programs.noctalia = {
            enable = true;
            systemd.enable = true;

            settings = {
              wallpaper.enabled = lib.mkDefault false;
            };
          };
        };
      };
    };
}
