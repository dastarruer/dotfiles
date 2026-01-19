{config, ...}: {
  home.file = {
    # Symlink the firefox chrome to its proper place
    ".mozilla/firefox/${config.home-manager.desktop.firefox.profile}/chrome" = {
      source = config.lib.file.mkOutOfStoreSymlink ./chrome;
      recursive = true;
    };

    # Generate the colors file
    ".cache/firefox/colors.css".text = ''
      /*

      ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
      │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
      └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘

      */

      :root {
      --sfwindow: #${config.lib.stylix.colors.base00};
      --sfsecondary: #${config.lib.stylix.colors.base01};
      }
    '';
  };

  # Settings from here: https://github.com/migueravila/Simplefox#Installation
  programs.firefox.profiles."${config.home-manager.desktop.firefox.profile}".settings = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;
    "svg.context-properties.content.enabled" = true;
  };
}
