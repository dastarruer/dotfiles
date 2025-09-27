{pkgs, ...}: {
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

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
