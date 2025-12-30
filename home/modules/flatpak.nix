/*
   https://github.com/in-a-dil-emma/declarative-flatpak

To find the link to a flatpak, run:
flatpak run {flatpak}
and then just take the link that it gives you.

Example: flatpak run net.ankiweb.Anki
error: app/net.ankiweb.Anki/x86_64/master not installed
*/
{pkgs, ...}: {
  # This is needed for launching flatpaks with rofi
  home.packages = with pkgs; [
    flatpak
  ];

  # FUTURE ME IF flatpak list throws an error, then run:
  # sudo rm -rf /var/lib/flatpak/repo
  # sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  # sudo flatpak remote-add --if-not-exists flathub-beta https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo
  services.flatpak = {
    enable = true;

    # Add remotes here
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };

    overrides = {
      global = {
        # Give all flatpaks access to the home dir
        filesystems = [
          "home"
        ];

        # Remove x11 support for flatpaks, making them run only on wayland
        sockets = [
          "!x11"
          "!fallback-x11"
        ];
      };
    };
  };
}
