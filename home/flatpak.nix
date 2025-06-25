/*
   https://github.com/in-a-dil-emma/declarative-flatpak

To find the link to a flatpak, run:
flatpak run {flatpak}
and then just take the link that it gives you.

Example: flatpak run net.ankiweb.Anki
error: app/net.ankiweb.Anki/x86_64/master not installed
*/
{inputs, ...}: {
  # Import flatpak home manager module
  imports = [
    inputs.flatpaks.homeModule
  ];

  services.flatpak = {
    # Enable flatpaks
    enable = true;

    # Add remotes here
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };

    # Add packages here
    packages = [
      "flathub:app/org.vinegarhq.Sober/x86_64/stable"
      "flathub:app/com.todoist.Todoist/x86_64/stable"
      "flathub:app/org.localsend.localsend_app/x86_64/stable"
    ];

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

      # It bothers me about this everytime I start sober so here
      "org.vinegarhq.Sober" = {
        filesystems = [
          "!home"
          "!host"
        ];
      };

      "com.todoist.Todoist" = {
        # Enable x11 support for todoist since it doesn't use wayland
        sockets = [
          "x11"
          "!wayland"
          "!fallback-x11"
        ];

        # disabled for now
        # environment = {
        #   OZONE_PLATFORM_HINT = null;
        # };
      };

      "md.obsidian.Obsidian" = {
        # Enable wayland support for obsidian
        sockets = [
          "wayland"
          "!x11"
          "!fallback-x11"
        ];

        # Disabled for now but its here js in case...
        # environment = {
        #   OZONE_PLATFORM_HINT = "auto";
        # };
      };
    };
  };
}
