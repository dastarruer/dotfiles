# Settings to make fonts less blurry
{...}: {
  flake.nixosModules.core = {...}: {
    # Reduce blurry fonts: https://www.reddit.com/r/xfce/comments/vfe7uy/comment/icyffxj/?force-legacy-sct=1
    environment.etc."environment".text = ''FREETYPE_PROPERTIES="truetype:interpreter-version=35"'';

    fonts.fontconfig = {
      enable = true;
      antialias = true;

      hinting = {
        enable = true;
        # This keeps the font shapes natural while still making it sharper
        style = "slight";
      };

      subpixel = {
        rgba = "rgb"; # Use rgb which is most common on most monitors
        lcdfilter = "light";
      };

      # Use full hinting for monospace fonts, since they look better when hinted
      # localConf = ''
      #   <match target="font">
      #     <test name="family" qual="any">
      #       <string>JetBrains Mono</string>
      #     </test>
      #     <edit name="hintstyle" mode="assign">
      #       <const>hintfull</const>
      #     </edit>
      #   </match>

      #   <match target="font">
      #     <test name="family" qual="any">
      #       <string>monospace</string>
      #     </test>
      #     <edit name="hintstyle" mode="assign">
      #       <const>hintfull</const>
      #     </edit>
      #   </match>
      # '';
    };
  };
}
