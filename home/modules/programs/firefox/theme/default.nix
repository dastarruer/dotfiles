{config, ...}: let
  firefoxProfile = "default";
in {
  home.file = {
    # Symlink the firefox chrome to its proper place
    ".mozilla/firefox/${firefoxProfile}/chrome" = {
      source = ./chrome;
      recursive = true;
    };

    # Generate the colors file
    ".mozilla/firefox/${firefoxProfile}/chrome/colors.css".text = ''
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
}
