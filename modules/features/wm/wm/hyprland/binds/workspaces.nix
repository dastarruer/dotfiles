{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    home-manager.users.dastarruer = lib.mkIf hyprland {
      wayland.windowManager.hyprland.settings = {
        config.binds = {
          allow_workspace_cycles = true; # Required for the SUPER+TAB keybind

          # If special workspace is active, changing to regular workspace hides it
          hide_special_on_workspace_change = true;
        };

        # Most unreadable thing ive seen in my life
        bind = [
          # Change workspaces
          {_args = ["SUPER + 1" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 1 })'')];}
          {_args = ["SUPER + 2" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 2 })'')];}
          {_args = ["SUPER + 3" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 3 })'')];}
          {_args = ["SUPER + 4" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 4 })'')];}
          {_args = ["SUPER + 5" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 5 })'')];}
          {_args = ["SUPER + 6" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 6 })'')];}
          {_args = ["SUPER + 7" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 7 })'')];}
          {_args = ["SUPER + 8" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 8 })'')];}
          {_args = ["SUPER + 9" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 9 })'')];}
          {_args = ["SUPER + 0" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 10 })'')];}
          {_args = ["SUPER + minus" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = 11 })'')];}
          {_args = ["SUPER + S" (lib.generators.mkLuaInline ''hl.dsp.workspace.toggle_special("magic")'')];}
          {_args = ["SUPER + TAB" (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "previous" })'')];}

          # Move windows to workspace
          {_args = ["SUPER + SHIFT + 1" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 1, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 2" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 2, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 3" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 3, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 4" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 4, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 5" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 5, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 6" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 6, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 7" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 7, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 8" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 8, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 9" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 9, follow = false })'')];}
          {_args = ["SUPER + SHIFT + 0" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 10, follow = false })'')];}
          {_args = ["SUPER + SHIFT + minus" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = 11, follow = false })'')];}
          {_args = ["SUPER + SHIFT + S" (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "special:magic", follow = false })'')];}
        ];
      };
    };
  };
}
