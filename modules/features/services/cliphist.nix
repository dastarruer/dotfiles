{...}: {
  flake.nixosModules.services_cliphist = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
    rofi = config.custom.wm.launcher == "rofi";

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
  in {
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
