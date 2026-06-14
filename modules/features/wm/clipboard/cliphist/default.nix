{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    launcher = config.custom.wm.launcher;

    hyprland = config.custom.wm.wm == "hyprland";
    clipboard = config.custom.wm.clipboard;
    rofi = launcher == "rofi";

    launchCmd =
      if rofi
      then "rofi -dmenu"
      else "";
    script = pkgs.writeShellApplication {
      name = "cliphist-wrapper";
      runtimeInputs = with pkgs;
        [
          wl-clipboard
          cliphist
        ]
        ++ lib.optionals rofi [
          pkgs.rofi
        ];

      text = ''
        cliphist list | ${launchCmd} | cliphist decode | wl-copy
      '';
    };
  in
    lib.mkIf (clipboard == "cliphist") {
      assertions = [
        {
          assertion = launcher != "noctalia";
          message = "cliphist does not work with noctalia. Instead, use noctalia to manage clipboard.";
        }
      ];

      home-manager.users.dastarruer = {
        services.cliphist = {
          enable = true;
        };

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          bind = [
            {_args = ["SUPER + V" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe script}")'')];}
          ];
        };
      };
    };
}
