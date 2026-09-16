{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
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
                "yuuto/calculator"
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
                "spacer"
                "yuuto/calculator:bar"
              ];
              end = [
                "apex077/eyecare:eyecare-widget"
              ];
            };
          };
        };
      };
    };
}
