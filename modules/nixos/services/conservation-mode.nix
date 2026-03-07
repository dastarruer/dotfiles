{
  pkgs,
  lib,
  ...
}: let
  service = "toggle-conservation";
  script = pkgs.writeShellApplication {
    name = "toggle-conservation-mode";
    runtimeInputs = with pkgs; [
      coreutils
    ];
    text = let
      batteryPath = "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode";
    in ''
      # sleep 5
      # Check if a monitor is disconnected
      if grep -q "disconnected" /sys/class/drm/card1-DP-1/status; then
        new=0
      else
        new=1
      fi

      # Write the value
      echo $new | tee ${batteryPath}
    '';
  };
in {
  # Needed for conservation mode on lenovo laptops (charging thresholds basically)
  boot.kernelModules = ["ideapad_laptop"];

  # It seems to work only when using a systemd service rather than a standalone script
  systemd.services.${service} = {
    description = "Toggle conservation mode based on HDMI connection";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${lib.getExe script}";
    };
  };

  # A udev rule to toggle conservation mode on monitor connect
  # https://wiki.archlinux.org/title/Udev
  # https://discourse.nixos.org/t/starting-user-system-service-from-udev-rules/5962 (but as a root service instead)
  # use udevadm monitor --property --udev command to get all these values
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}+="${service}.service"
  '';
}
