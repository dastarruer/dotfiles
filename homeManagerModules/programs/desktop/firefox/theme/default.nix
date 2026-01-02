{config, ...}: {
  home.file = {
    # Symlink the firefox chrome to its proper place
    ".mozilla/firefox/config.dotfiles.desktop.firefox.profile/chrome" = {
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
}
