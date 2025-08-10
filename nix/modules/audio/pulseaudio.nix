{...}: {
  # Enable sound with pipewire, which is better for wayland
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
