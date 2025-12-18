# For future me, this does not bulid because of the following error:
# error: attribute 'ax-send' missing
# at /nix/store/8xvrkl0fh5nz4hscmn3v1jffd69j2kc6-source/nix/modules/home-manager.nix:474:7:
#   473|       wrappedPackage
#   474|       pkgs.ax-send
#       |       ^
#   475|       pkgs.wl-clipboard
{inputs, ...}: {
  imports = [
    inputs.ax-shell.homeManagerModules.default
  ];

  programs.ax-shell = {
    enable = true;

    settings = {
      wallpapersDir = "${../../../config/wallpapers}";
    };
  };
}
