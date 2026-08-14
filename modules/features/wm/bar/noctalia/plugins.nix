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
        # Not ideal, but dependencies need to be installed globally for now
        home.packages = with pkgs; [
          # eyecare
          pipewire # pw-play
          dbus # dbus-monitor

          # phone-connect
          kdePackages.kdeconnect-kde
          glib # gdbus
          sshfs # phone file browsing
        ];
        
        programs.noctalia.settings = {
          plugins = {
            enabled = [
              "apex077/eyecare"
              "icefish/phone-connect"
              "noctalia/timer"
              "yuuto/calculator"
            ];
            
            # Manage plugin updates with nix
            auto_update = false;
            source = [
              {
                name = "official";
                kind = "git";
                location = inputs.noctalia-official-plugins;
                enabled = true;
              }
              {
                name = "community";
                kind = "git";
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
}
