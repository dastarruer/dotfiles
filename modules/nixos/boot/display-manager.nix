{config, ...}: {
  services.displayManager = {
    # SDDM is compatible with wayland and hyprland so im not using lightdm
    sddm = {
      wayland.enable = true;
      enable = true;

      # Define SDDM config
      settings = {
        General = {
          background = "${config.home.homeDirectory}/Pictures/wallpaper";
        };

        Autologin = {
          Session = "hyprland-uwsm";
          User = "dastarruer";
        };
      };
    };
  };

  # Autologin me so i dont get login prompt on boot
  services.getty.autologinUser = "dastarruer";
}
