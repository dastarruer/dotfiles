# Settings to make fonts less blurry
{...}: {
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "full"; # Best for monospace fonts, though not great for other fonts
    subpixelRendering = "vertical-rgb"; # Seems to reduce color fringing more on my monitor as opposed to rgb

    # Set lcdfilter to light manually, since hm does not yet have an option to do this yet
    configFile."lcdfilter-light" = {
      enable = true;
      label = "lcdfilter-light";
      priority = 10;
      text = ''
        <match target="font">
            <edit name="lcdfilter" mode="assign">
            <const>lcdlight</const>
            </edit>
        </match>
      '';
    };
  };
}
