{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = config.custom.wm.wm == "hyprland";
    bar = config.custom.wm.bar.bar;
  in
    lib.mkIf (bar == "noctalia") {
      home-manager.users.dastarruer = {
        programs.noctalia = {
          package =
            # Add plugin dependencies
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs
            (old: {
              postFixup =
                builtins.replaceStrings
                ["${pkgs.lib.makeBinPath [pkgs.git]}"]
                [
                  "${pkgs.lib.makeBinPath (with pkgs; [
                    git
                    # eyecare
                    pipewire # pw-play
                    dbus # dbus-monitor

                    # phone-connect
                    kdePackages.kdeconnect-kde
                    glib # gdbus
                    sshfs # phone file browsing

                    # calculator-plus
                    libqalculate
                  ])}"
                ]
                old.postFixup;
            });

          settings = {
            plugins = {
              enabled = [
                "apex077/eyecare"
                "icefish/phone-connect"
                "noctalia/timer"
                "samuelskovbakke/calculator-plus"
              ];

              # Manage plugin updates with nix
              auto_update = "none";
              source = [
                {
                  name = "official";
                  kind = "path";
                  location = inputs.noctalia-official-plugins;
                  enabled = true;
                }
                {
                  name = "community";
                  kind = "path";
                  location = inputs.noctalia-community-plugins;
                  enabled = true;
                }
              ];
            };

            bar.plugins = {
              enabled = true;
              position = "bottom";
              reserve_space = false;
              layer = "overlay";
              margin_ends = 500;

              smart_auto_hide = true;
              show_on_workspace_switch = false;

              radius_top_left = 12;
              radius_top_right = 12;
              radius_bottom_left = 0;
              radius_bottom_right = 0;

              start = [
                "noctalia/timer:bar"
              ];
              center = [
                "icefish/phone-connect:bar"
                # "spacer"
              ];
              end = [
                "apex077/eyecare:eyecare-widget"
              ];
            };
          };
        };

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
          bind = [
            # Calculator
            {_args = ["SUPER + C" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${lib.getExe hmConfig.programs.noctalia.package} msg panel-toggle samuelskovbakke/calculator-plus:panel")'')];}
          ];
        };
      };
    };
}
