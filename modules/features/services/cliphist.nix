{...}: {
  flake.nixosModules.services_cliphist = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = hmConfig.wayland.windowManager.hyprland;
    rofi = hmConfig.programs.rofi;

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

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        bind = [
          {_args = ["SUPER + V" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe script}")'')];}
        ];
      };
    };
  };
}
