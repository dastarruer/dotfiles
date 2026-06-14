{self, ...}: {
  flake.nixosModules.laptopConfiguration = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = with self.nixosModules; [
      laptopHardware
      laptopDisk
      laptopHome

      core
      shell
      wm

      hardware
      hardware_logind
      hardware_power-management

      cli_btop
      cli_direnv
      cli_git
      cli_yazi
      cli_zoxide
      cli_multiplexer

      desktop_anki
      desktop_firefox
      desktop_steam
      desktop_lutris
      desktop_whatsapp
      desktop_spicetify
      desktop_terminal
      desktop_editor
      desktop_calibre
      desktop_imv
      desktop_kdenlive
      desktop_krita
      desktop_libreoffice
      desktop_todoist
      desktop_mpv
      desktop_obs
      desktop_zathura
      desktop_timer
      desktop_kdeconnect

      services_backup
      services_ludusavi
      # services_caps-lock-monitor
      services_smart-pause-resume
      services_conservation-mode
      services_reload-udev
      services_docker
      services_ssh

      self-hosted_sunshine
    ];

    custom = {
      theme = {
        name = "everforest-dark-hard";
        accent = config.lib.stylix.colors.base0B;
      };

      hardware = {
        power-management = "power-profiles-daemon";
        monitors = [
          # Main monitor in the middle
          {
            name = "DP-1";
            workspaces = [1 2 3 4 5 6 7 8 9 10];
            backlightDevice = "ddcci7";
            position = {
              x = 0;
              y = 0;
            };
            resolution = {
              width = 1920;
              height = 1080;
              rate = 120.0;
            };
          }
          # Laptop monitor
          {
            name = "eDP-1";
            workspaces = [11];
            backlightDevice = "amdgpu_bl1";
            position = {
              x = 1920;
              y = 0;
            };
            resolution = {
              width = 1920;
              height = 1080;
              rate = 60.0;
            };
          }
        ];
      };

      wm = {
        locker.kind = "noctalia";
        idle-daemon = "noctalia";
        bar.bar = "noctalia";
        night-light = "noctalia";
        wallpaper-daemon = "noctalia";
        notifications.daemon = "noctalia";
        launcher = "noctalia";
        clipboard = "noctalia";
      };

      cli = {
        multiplexer = "tmux";
      };

      desktop = {
        editor = "zed";
        terminal = "foot";
      };

      backup.backupPaths = [
        "${config.home-manager.users.dastarruer.home.homeDirectory}/Music"
        "${config.home-manager.users.dastarruer.home.homeDirectory}/Documents/sheet-music"
        "${config.home-manager.users.dastarruer.home.homeDirectory}/Documents/school"
        "${config.home-manager.users.dastarruer.home.homeDirectory}/Pictures/trips"
      ];
    };

    # Disable touchpad as mouse for dualshock connected via USB and Bluetooth (https://wiki.archlinux.org/title/Gamepad#Disable_touchpad_acting_as_mouse)
    services.udev.extraRules = ''
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';

    home-manager.users.dastarruer = {
      systemd.user = let
        service = "cargo-clean";

        hmConfig = config.home-manager.users.dastarruer;
        devPath = "${hmConfig.home.homeDirectory}/Documents/dev";
        script = pkgs.writeShellApplication {
          name = "cargo-clean-wrapper";
          runtimeInputs = [pkgs.cargo-clean-recursive];
          text = ''
            cargo-clean-recursive clean-recursive ${devPath}
          '';
        };
      in {
        services.${service} = {
          Unit.Description = "Clean unused cargo build artifacts in ${devPath}";
          Service = {
            Type = "oneshot";
            ExecStart = "${lib.getExe script}";
          };
        };

        timers.${service} = {
          Unit.Description = "Timer for ${service} service";
          Timer.OnCalendar = "weekly";
          Install.WantedBy = ["timers.target"];
        };
      };
    };
  };
}
