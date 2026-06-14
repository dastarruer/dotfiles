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
        config = {
          general = {
            gaps_in = 5;
            gaps_out = 20;
            border_size = 4;
          };

          decoration = {
            rounding = 0;
            rounding_power = 2;

            active_opacity = 1.0;
            inactive_opacity = 0.85;
            fullscreen_opacity = 1.0;
            dim_inactive = false;
            dim_strength = 0.05;

            shadow = {
              enabled = true;
              range = 35;
              render_power = 3;
              offset = "15 15";
            };

            blur = {
              enabled = true;
              size = 5;
              passes = 5;
              ignore_opacity = true;
              popups = true;
              new_optimizations = true;
            };
          };
        };

        curve = [
          {_args = ["overshot" (lib.generators.mkLuaInline ''{ type = "bezier", points = { {0, 0.9}, {0.1, 1.15} } }'')];}
          {_args = ["smoothOut" (lib.generators.mkLuaInline ''{ type = "bezier", points = { {0.36, 0}, {0.66, -0.56} } }'')];}
          {_args = ["smoothIn" (lib.generators.mkLuaInline ''{ type = "bezier", points = { {0.25, 1}, {0.5, 1} } }'')];}
        ];
        animation = [
          # Windows
          {
            leaf = "windows";
            enabled = true;
            speed = 3;
            bezier = "overshot";
            style = "slide";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 3;
            bezier = "smoothOut";
            style = "slide";
          }
          {
            leaf = "windowsMove";
            enabled = true;
            speed = 3;
            bezier = "default";
          }
          # Layers
          {
            leaf = "layers";
            enabled = true;
            speed = 3;
            bezier = "overshot";
            style = "slide";
          }
          {
            leaf = "layersOut";
            enabled = true;
            speed = 3;
            bezier = "smoothOut";
            style = "slide";
          }
          # Workspaces
          {
            leaf = "workspaces";
            enabled = true;
            speed = 3;
            bezier = "smoothIn";
          }
          {
            leaf = "specialWorkspace";
            enabled = true;
            speed = 3;
            bezier = "overshot";
            style = "slidevert";
          }
          {
            leaf = "specialWorkspaceOut";
            enabled = true;
            speed = 3;
            bezier = "smoothIn";
            style = "slidevert";
          }
          # Other
          {
            leaf = "border";
            enabled = true;
            speed = 3;
            bezier = "default";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 3;
            bezier = "smoothIn";
          }
          {
            leaf = "fadeDim";
            enabled = true;
            speed = 3;
            bezier = "smoothIn";
          }
        ];
      };
    };
  };
}
