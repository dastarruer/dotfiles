# Various tweaks from https://www.reddit.com/r/hyprland/comments/1uxwh5a/lets_discuss_our_hyprland_specific_gaming_tweaks/?solution=694474f1ca1733aa694474f1ca1733aa&js_challenge=1&token=7afd7253fec22262ff1c52b1703fe9ec5dfadd38f391586a24f562b074a41c86&jsc_orig_r=
{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    home-manager.users.dastarruer = lib.mkIf hyprland {
      wayland.windowManager.hyprland.settings = {
        config = {
          general.allow_tearing = true;
          # misc.vrr = 3;
          # render.direct_scanout = 0;
          cursor = {
            no_hardware_cursors = 0;
            no_break_fs_vrr = 0;
          };
        };

        bind = [
          # suspend an app, freeing resources for other processes
          {
            _args = [
              "SUPER + X"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe pkgs.wl-freeze} -a")'')
            ];
          }
        ];

        window_rule = [
          {
            match = {
              tag = "game";
              fullscreen = true;
            };
            confine_pointer = true;
            border_size = 0;
            rounding = 0;
            decorate = false;
            force_rgbx = true;
            sync_fullscreen = true;
            no_anim = true;
            no_blur = true;
            no_dim = true;
            no_max_size = true;
            no_shadow = true;
            persistent_size = true;
            focus_on_activate = false;
            immediate = true;
            idle_inhibit = "always";
          }
        ];
      };
    };
  };
}
