{pkgs, ...}: {
  # From https://wiki.nixos.org/wiki/PipeWire
  # having issues with your headset again? try this!!! https://wiki.archlinux.org/title/Bluetooth_headset#Switch_between_HSP/HFP_and_A2DP_setting
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
