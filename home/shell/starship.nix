{...}: {
  programs.starship = {
    enable = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      # Character prompt
      character = {
        success_symbol = "[[󰄛](green) ❯](peach)";
        error_symbol = "[[󰄛](color5) ❯](peach)";
        vimcmd_symbol = "[󰄛 ❮](subtext1)";
      };

      # Directory style
      directory = {
        truncation_length = 4;
      };
    };
  };
}
