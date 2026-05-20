# Systemd service to reload udev rules on resume from suspend
{...}: {
  flake.nixosModules.services_reload-udev = {
    pkgs,
    lib,
    ...
  }: {
    config = let
      script = pkgs.writeShellApplication {
        name = "reload-udev";
        runtimeInputs = with pkgs; [
          systemdMinimal
        ];
        text = ''
          udevadm control --reload-rules
          udevadm trigger --type=subsystems
        '';
      };
    in {
      systemd.services."reload-udev" = {
        enableStrictShellChecks = true;

        description = "Reload udev rules on resume from suspend";
        after = ["suspend.target"];

        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${lib.getExe script}";
        };

        wantedBy = ["suspend.target"];
      };
    };
  };
}
