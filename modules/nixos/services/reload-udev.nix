# Systemd service to reload udev rules on resume from suspend
{
  pkgs,
  lib,
  ...
}: let
  script = pkgs.writeShellApplication {
    name = "reload-udev";
    runtimeInputs = with pkgs; [
      systemdMinimal
    ];
    text = ''
      udevadm control --reload-rules && udevadm trigger
    '';
  };
in {
  systemd.services."reload-udev" = {
    enableStrictShellChecks = true;

    description = "Reload udev rules on resume from suspend";
    after = ["sleep.target"];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${lib.getExe script}";
    };

    wantedBy = ["sleep.target"];
  };
}
