{self, ...}: {
  flake.nixosModules.laptopConfiguration = {...}: {
    imports = with self.nixosModules; [
      laptopHardware
      laptopDisk
      laptopHome

      core
      shell

      hardware
      hardware_logind
      hardware_power-management

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
      desktop_kdeconnect

      services_backup
      services_ludusavi
      services_caps-lock-monitor
      services_smart-pause-resume
      services_conservation-mode
      services_reload-udev
      services_docker
      services_ssh
    ];

    # Gives extra ram basically
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
    };

    # Disable touchpad as mouse for dualshock connected via USB and Bluetooth (https://wiki.archlinux.org/title/Gamepad#Disable_touchpad_acting_as_mouse)
    services.udev.extraRules = ''
      ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
      ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    '';
  };
}
