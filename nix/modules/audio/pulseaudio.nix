{...}: {
  # idk what any of this does idek if this enables puleaudio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Fix bluetooth or something idk
    wireplumber.enable = true;
  };
}
