{...}: {
  flake.nixosModules.hardware = {
    config,
    lib,
    ...
  }: {
    options.custom.hardware = {
      power-management = lib.mkOption {
        type = lib.types.enum ["tlp" "auto-cpufreq" "power-profiles-daemon" "none"];
        default = "none";
        description = "Set the power management daemon to be used.";
      };
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
            backlightBackend = lib.mkOption {
              type = lib.types.enum ["none" "backlight" "ddcutil"];
              default = "none";
              description = "Which tool to use to control this monitor's backlight.";
            };
            busNumber = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
              description = "Used for external monitors to be handled via ddcutil. Can be left null for laptop monitors.";
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

    config = {
      assertions =
        map (m: {
          assertion = m.backlightBackend == "ddcutil" -> m.busNumber != null;
          message = "Monitor '${m.name}' is configured to use 'ddcutil' as its backlightBackend, but 'busNumber' is null. You must specify a valid I2C bus number (e.g., 7) using 'sudo ddcutil detect'";
        })
        config.custom.hardware.monitors;
    };
  };
}
