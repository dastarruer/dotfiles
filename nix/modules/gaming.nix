# Defines settings for better gaming experience.
# Programs for gaming are installed w home-manager, not here
{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # should install mesa graphics drivers?
    extraPackages = with pkgs; [
      mesa
      vulkan-loader
      vulkan-tools
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      vulkan-loader
    ];
  };

  # Idk if this gets used by integrated graphics but yk why not
  services.xserver.videoDrivers = ["amdgpu"];
}
