{...}: {
  flake.nixosModules.wm = {
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings = {
        bind = [
          {_args = ["SUPER + mouse:272" (lib.generators.mkLuaInline "hl.dsp.window.drag()")];}
          {_args = ["SUPER + SHIFT + K" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.hyprland}/bin/hyprctl kill")'')];}
        ];
      };
    };
  };
}
