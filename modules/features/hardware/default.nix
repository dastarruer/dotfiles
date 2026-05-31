{...}: {
  flake.nixosModules.hardware = {lib, ...}: {
    options.custom.hardware = {
      monitors = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Monitor name (e.g. DP-1, HDMI-1)";
            };
            workspaces = lib.mkOption {
              type = lib.types.listOf lib.types.int;
              description = "Workspaces assigned to this monitor.";
            };
            backlightDevice = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Brillo backlight device for this monitor (e.g. amdgpu_bl1, ddcci7). Null = not controllable.";
            };
            position = lib.mkOption {
              type = lib.types.submodule {
                options = {
                  x = lib.mkOption {
                    type = lib.types.int;
                    default = 0;
                    description = "X offset in pixels";
                  };
                  y = lib.mkOption {
                    type = lib.types.int;
                    default = 0;
                    description = "Y offset in pixels";
                  };
                };
              };
              default = {
                x = 0;
                y = 0;
              };
              description = "Top-left pixel position of the monitor";
            };
            resolution = lib.mkOption {
              type = lib.types.nullOr (lib.types.submodule {
                options = {
                  width = lib.mkOption {type = lib.types.int;};
                  height = lib.mkOption {type = lib.types.int;};
                  rate = lib.mkOption {
                    type = lib.types.float;
                    default = 60.0;
                  };
                };
              });
              default = null;
              description = "Resolution and refresh rate, null = use preferred";
            };
            scale = lib.mkOption {
              type = lib.types.float;
              default = 1.0;
              description = "Output scale factor";
            };
            transform = lib.mkOption {
              type = lib.types.enum ["normal" "90" "180" "270" "flipped" "flipped-90" "flipped-180" "flipped-270"];
              default = "normal";
              description = "Output rotation/flip transform";
            };
          };
        });
        default = [];
      };
    };
  };
}
