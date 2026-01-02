{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    dotfiles.libreoffice.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable libreoffice.";
    };
  };

  config = lib.mkIf config.dotfiles.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice
    ];

    xdg.mimeApps.defaultApplications = {
      # --- Documents (Writer) ---
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["libreoffice-writer.desktop"]; # .docx
      "application/msword" = ["libreoffice-writer.desktop"]; # .doc
      "application/vnd.oasis.opendocument.text" = ["libreoffice-writer.desktop"]; # .odt
      "application/rtf" = ["libreoffice-writer.desktop"]; # .rtf

      # --- Spreadsheets (Calc) ---
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["libreoffice-calc.desktop"]; # .xlsx
      "application/vnd.ms-excel" = ["libreoffice-calc.desktop"]; # .xls
      "application/vnd.oasis.opendocument.spreadsheet" = ["libreoffice-calc.desktop"]; # .ods
      "text/csv" = ["libreoffice-calc.desktop"]; # .csv

      # --- Presentations (Impress) ---
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["libreoffice-impress.desktop"]; # .pptx
      "application/vnd.ms-powerpoint" = ["libreoffice-impress.desktop"]; # .ppt
      "application/vnd.oasis.opendocument.presentation" = ["libreoffice-impress.desktop"]; # .odp
    };
  };
}
