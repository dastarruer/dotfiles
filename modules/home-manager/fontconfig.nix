# Settings to make fonts less blurry
{...}: {
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "slight"; # This keeps the font shapes natural while still making it sharper
    subpixelRendering = "rgb";

    # Set lcdfilter to light manually, since hm does not yet have an option to do this yet
    configFile = {
      "lcdfilter-light" = {
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
      # Enable full hinting for select monospace fonts; will make them sharper
      # Full hinting looks worse on non-monospace fonts
      "full-hinting-for-monospace" = {
        enable = true;
        label = "full-hinting-for-monospace";
        priority = 10;
        text = ''
          <match target="font">
              <test name="family" qual="any">
                  <string>JetBrains Mono</string>
              </test>
              <edit name="hintstyle" mode="assign">
                  <const>hintfull</const>
              </edit>
              <edit name="hinting" mode="assign">
                  <bool>true</bool>
              </edit>
          </match>'';
      };
    };
  };
}
