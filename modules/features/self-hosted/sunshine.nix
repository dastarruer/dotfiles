{...}: {
  flake.nixosModules.self-hosted_sunshine = {config, ...}: let
    wayland = config.custom.wm.wayland;
  in {
    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = wayland; # Needed on wayland

      # These settings seem to work best for my laptop specifically. Maybe this can be set with custom options but eh can't be bothered for now
      settings = {
        capture = "kms";
        hevc_encoder = 0;
        encoder = "vaapi";
      };
    };

    # Permit sunshine to emulate virtual devices such as mouse and keyboard
    hardware.uinput.enable = true;
    users.users.dastarruer.extraGroups = ["uinput"];
  };
}
