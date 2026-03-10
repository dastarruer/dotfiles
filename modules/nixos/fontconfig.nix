# Settings to make fonts less blurry
{...}: {
  fonts.fontconfig = {
    enable = true;
    antialias = true;

    hinting = {
      enable = true;
      # This keeps the font shapes natural while still making it sharper
      # style = "slight";

      # Fully conforms fonts to the pixel grid, making it sharper but less natural
      style = "full";

      # Use the font's own hinting instructions, which can be better for some fonts but worse for others
      autohint = false;
    };

    subpixel = {
      rgba = "rgb"; # Use rgb which is most common on most monitors
      lcdfilter = "light";
    };
  };
}
