{self, ...}: {
  flake.nixosModules.laptopConfiguration = {...}: {
    imports = with self.nixosModules; [
      laptopHardware
      laptopDisk
      laptopHome

      core

      shell

      cli_btop
      cli_direnv
      cli_git
      cli_yazi
      cli_zoxide

      desktop_anki
      desktop_firefox
      desktop_steam
      desktop_whatsapp
      desktop_spicetify
      desktop_terminal
      desktop_vscode
      desktop_calibre
      desktop_imv
      desktop_kdenlive
      desktop_krita
      desktop_libreoffice
      desktop_mpv
      desktop_obs
      desktop_zathura
      desktop_timer

      services_backup
      services_ludusavi
      services_caps-lock-monitor
      services_smart-pause-resume
      services_conservation-mode
    ];

    # Suppress warning (https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion)
    system.stateVersion = "25.05";
    nixpkgs.config.allowUnfree = true;

    # Enable ssh
    services.openssh.enable = true;
    services.flatpak.enable = true;

    nix.settings = {
      max-jobs = "auto";

      # Enable flakes
      experimental-features = ["nix-command" "flakes"];

      # Use nix-community binary cache to avoid building from source as much as possible
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    # Microcode updates (might as well yk)
    services.ucodenix = {
      # enable = true;
      # it don't work
      enable = false;
      cpuModelId = "auto";
    };

    # Allow fonts to work with flatpak (https://wiki.nixos.org/wiki/Fonts#Flatpak_applications_can't_find_system_fonts)
    # If any issues arise, read through the wiki
    # Note that home-manager flatpak configuration is in flatpak.nix
    fonts.fontDir.enable = true;

    # Gives extra ram basically
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
    };

    boot.kernel.sysctl = {
      # Only use swap when completely necessary
      "vm.swappiness" = 20;

      # For RAM intensive applications that may not use all the ram it allocates, promise more ram than is available (only up to a certain point. Otherwise, the process may be killed by earlyoom).
      # https://medium.com/@charles.vissol/optimize-your-linux-69c70320d852
      # "vm.overcommit-memory" = 2;
      "vm.overcommit-memory" = 0;

      # write dirty pages to disk once 5% of ram holds dirty pages
      # https://medium.com/@charles.vissol/optimize-your-linux-69c70320d852
      "vm.dirty_background_ratio" = 5;
    };

    # Reduce blurry fonts: https://www.reddit.com/r/xfce/comments/vfe7uy/comment/icyffxj/?force-legacy-sct=1
    environment.etc."environment".text = ''FREETYPE_PROPERTIES="truetype:interpreter-version=35"'';

    # Disable touchpad as mouse for dualshock connected via USB and Bluetooth (https://wiki.archlinux.org/title/Gamepad#Disable_touchpad_acting_as_mouse)
    services.udev.extraRules = ''
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';
  };
}
