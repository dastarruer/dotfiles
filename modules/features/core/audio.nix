{...}: {
  flake.nixosModules.core = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    # From https://wiki.nixos.org/wiki/PipeWire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true; # if not already enabled
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment the following
      #jack.enable = true;
    };

    # Make headphones use a2dp audio profile: https://wiki.archlinux.org/title/Bluetooth_headset#A2DP_sink_profile_is_unavailable
    hardware.bluetooth.settings.General = {
      Disable = "Headset";
      MultiProfile = "multiple";
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];

    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings.window_rule = lib.mkIf hyprland [
        {
          match.class = "org.pulseaudio.pavucontrol";
          float = true;
          pin = true;
          size = lib.generators.mkLuaInline "{933, 400}";
        }
      ];
    };
  };
}
