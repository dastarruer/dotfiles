{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
    options.custom.wm = {
      monitors = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Monitor name (e.g. DP-1, HDMI-1)";
            };
            workspaces = lib.mkOption {
              type = lib.types.listOf lib.types.int;
              description = "Workspaces assigned to this monitor";
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

      wm = lib.mkOption {
        type = lib.types.enum ["hyprland"];
        default = "hyprland";
        description = "Set the window manager to be used.";
      };
      wayland = lib.mkOption {
        type = lib.types.bool;
        readOnly = true;
        default = builtins.elem config.custom.wm.wm ["hyprland"];
        description = "Whether the selected window manager is a Wayland compositor (derived automatically).";
      };

      locker = lib.mkOption {
        type = lib.types.enum ["hyprlock" "swaylock" "none"];
        default = "hyprlock";
        description = "Set the screen locker to be used.";
      };
      bar = lib.mkOption {
        type = lib.types.enum ["waybar" "none"];
        default = "waybar";
        description = "Set the bar to be used.";
      };
      notifications.daemon = lib.mkOption {
        type = lib.types.enum ["dunst" "none"];
        default = "dunst";
        description = "Set the notification daemon to be used.";
      };
      launcher = lib.mkOption {
        type = lib.types.enum ["rofi" "sherlock" "none"];
        default = "rofi";
        description = "Set the launcher to be used.";
      };
      idle-daemon = lib.mkOption {
        type = lib.types.enum ["hypridle" "none"];
        default = "hypridle";
        description = "Set the idle daemon to be used.";
      };
      night-light = lib.mkOption {
        type = lib.types.enum ["hyprsunset" "none"];
        default = "hyprsunset";
        description = "Set the night-light filter utility to be used.";
      };
    };
  };
}
