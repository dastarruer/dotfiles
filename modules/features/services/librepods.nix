{...}: {
  flake.nixosModules.services_librepods = {...}: {
    programs.librepods.enable = true;

    # https://github.com/librepods-org/librepods#vendorid-spoofing
    hardware.bluetooth.settings.General.DeviceID = "bluetooth:004C:0000:0000";

    # Sudoless access to librepods
    users.users.dastarruer.extraGroups = [
      "librepods"
    ];
  };
}
