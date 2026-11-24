{...}: {
  flake.nixosModules.services_librepods = {
    pkgs,
    lib,
    ...
  }: {
    programs.librepods.enable = true;

    # https://github.com/librepods-org/librepods#vendorid-spoofing
    hardware.bluetooth.settings.General.DeviceID = "bluetooth:004C:0000:0000";

    # Sudoless access to librepods
    users.users.dastarruer.extraGroups = [
      "librepods"
    ];

    systemd.user.services.librepods = {
      description = "Auto-start librepods";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = lib.getExe pkgs.librepods;
        # Qt 6.5+ dlopens libxcb-cursor for the xcb plugin
        Environment = [
          "LD_LIBRARY_PATH=${lib.makeLibraryPath [pkgs.xcb-util-cursor]}"
        ];
        Restart = "on-failure";
        RestartSec = 3;
      };
      unitConfig = {
        StartLimitIntervalSec = 60;
        StartLimitBurst = 5;
      };
    };
  };
}
