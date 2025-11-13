# Systemd service to reload udev rules on resume from suspend
{pkgs, ...}: {
  systemd.services."reload-udev" = {
    enableStrictShellChecks = true;

    description = "Reload udev rules on resume from suspend";
    after = ["sleep.target"];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.writeShellScript "reload-udev" ''
        #!/run/current-system/sw/bin/bash
        ${pkgs.systemdMinimal}/bin/udevadm control --reload-rules && ${pkgs.systemdMinimal}/bin/udevadm trigger
      ''}";
    };

    wantedBy = ["sleep.target"];
  };
}
