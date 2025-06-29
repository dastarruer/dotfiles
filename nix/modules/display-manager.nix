{...}: {
  services.displayManager = {
    defaultSession = "hyprland-uwsm";

    # SDDM is compatible with wayland and hyprland so im not using lightdm
    sddm = {
      wayland.enable = true;
      enable = true;

      # Define SDDM config
      settings = {
        General = {
          background = "/home/dastarruer/Pictures/wallpapers/gruvbox/wall.jpg";
        };

        Autologin = {
          Session = "hyprland-uwsm";
          User = "dastarruer";
        };
      };
    };
  };
}
