{
  inputs,
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.cli.shell.fastfetch.enable = lib.mkEnableOption "Enable fastfetch.";
  };

  config = lib.mkIf config.dotfiles.cli.shell.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          source = "${inputs.self.outPath}/config/images/pfp.png";
          type = "kitty";
          height = 6;
          width = 12;
          padding = {
            # top = 1;
            # left = 4;
          };
        };
        display = {
          separator = "";
          color = {
            keys = "1;94";
            separator = "0;94";
          };
          key = {
            width = 10;
          };
        };
        modules = [
          {
            type = "command";
            key = " ";
            text = "echo \"hello, dastarruer\"";
          }
          {
            type = "os";
            format = "{2}";
          }
          {
            type = "wm";
            format = "{1}";
          }
          {
            type = "shell";
            format = "{1}";
          }
          {
            type = "command";
            key = "Age";
            # Use double single-quotes to escape the $ in shell commands within Nix strings
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          "uptime"
          {
            type = "packages";
            format = "{2} + {44}";
          }
          "break"
          {
            type = "colors";
            symbol = "circle";
          }
          "break"
        ];
      };
    };
  };
}
