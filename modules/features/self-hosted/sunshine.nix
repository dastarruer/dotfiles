{...}: {
  flake.nixosModules.self-hosted_sunshine = {
    config,
    pkgs,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;

    doCmd = pkgs.writeShellApplication {
      name = "doCmd";
      runtimeInputs = [
        pkgs.hyprland
      ];

      # Configure headless display to match client resolution and refresh rate
      text = ''
        hyprctl dispatch "hl.dsp.exec_cmd('hyprctl keyword monitor HDMI-A-1,''${SUNSHINE_CLIENT_WIDTH}x''${SUNSHINE_CLIENT_HEIGHT}@''${SUNSHINE_CLIENT_FPS},3840x0,1')"
      '';
    };
    undoCmd = pkgs.writeShellApplication {
      name = "undoCmd";
      runtimeInputs = [
        pkgs.hyprland
      ];

      # Reset headless display
      text = ''
        hyprctl dispatch "hl.dsp.exec_cmd('hyprctl keyword monitor HDMI-A-1,'preferred,3840x0,1')"
      '';
    };
  in {
    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = wayland; # Needed on wayland

      # These settings seem to work best for my laptop specifically. Maybe this can be set with custom options but eh can't be bothered for now
      settings = {
        capture = "kms";
        hevc_encoder = 1; # Allow hevc for ios devices
        encoder = "auto";
        output_name = 1; # Set output to headless display
      };

      applications = {
        apps = [
          {
            name = "Big Picture Mode (Steam)";
            cmd = "${lib.getExe config.programs.steam.package} -gamepadui";
            prep-cmd = [
              {
                do = "${lib.getExe doCmd}";
                undo = "${lib.getExe undoCmd}";
              }
            ];
            exclude-global-prep-cmd = "false";
            auto-detach = "true";
          }
        ];
      };
    };

    # Permit sunshine to emulate virtual devices such as mouse and keyboard
    hardware.uinput.enable = true;
    users.users.dastarruer.extraGroups = ["uinput"];

    hardware.display.edid.packages = [
      (pkgs.runCommand "sunshine-headless-edid" {} ''
        mkdir -p $out/lib/firmware/edid
        cp "${pkgs.fetchurl {
          url = "https://git.linuxtv.org/v4l-utils.git/plain/utils/edid-decode/data/samsung-q800t-hdmi2.1";
          hash = "sha256-0KbqdA08If4BWnSCHT+/w6pI3toIO2ktbI+qeX8Ne2Q=";
        }}" $out/lib/firmware/edid/samsung-q800t-hdmi2.1.bin
      '')
    ];

    # Create headless display to stream from
    hardware.display.outputs."HDMI-A-1" = {
      mode = "e";
      edid = "samsung-q800t-hdmi2.1.bin";
    };
  };
}
