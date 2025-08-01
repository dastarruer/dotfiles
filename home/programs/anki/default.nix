{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (anki.withAddons (with ankiAddons; [
      (passfail2.withConfig {
        config = {
          again_button_name = "Incorrect";
          good_button_name = "Correct";
          toggle_names_textcolors = 1;
        };
      })
      (recolor.withConfig {
        config = {
          colors = {
            BORDER = [
              "Border"
              "#${config.lib.stylix.colors.base00}"
              "#${config.lib.stylix.colors.base00}"
              "--border"
            ];
            BURIED_FG = [
              "Buried Foreground"
              "#${config.lib.stylix.colors.base01}"
              "#${config.lib.stylix.colors.base01}"
              "--buried-fg"
            ];
            BUTTON_BG = [
              "Button Background"
              "#${config.lib.stylix.colors.base02}"
              "#${config.lib.stylix.colors.base02}"
              "--button-bg"
            ];
            CURRENT_DECK = [
              "Selected Deck"
              "#${config.lib.stylix.colors.base03}"
              "#${config.lib.stylix.colors.base03}"
              "--current-deck"
            ];
            DISABLED = [
              "Disabled"
              "#${config.lib.stylix.colors.base04}"
              "#${config.lib.stylix.colors.base04}"
              "--disabled"
            ];
            FAINT_BORDER = [
              "Faint Border"
              "#${config.lib.stylix.colors.base05}"
              "#${config.lib.stylix.colors.base05}"
              "--faint-border"
            ];
            FLAG1_BG = [
              "Flag1 (Browse Cards List)"
              "#${config.lib.stylix.colors.base06}"
              "#${config.lib.stylix.colors.base06}"
              "--flag1-bg"
            ];
            FLAG1_FG = [
              "Flag1 (Browse Sidebar)"
              "#${config.lib.stylix.colors.base07}"
              "#${config.lib.stylix.colors.base07}"
              "--flag1-fg"
            ];
            FLAG2_BG = [
              "Flag2 (Browse Cards List)"
              "#${config.lib.stylix.colors.base08}"
              "#${config.lib.stylix.colors.base08}"
              "--flag2-bg"
            ];
            FLAG2_FG = [
              "Flag2 (Browse Sidebar)"
              "#${config.lib.stylix.colors.base09}"
              "#${config.lib.stylix.colors.base09}"
              "--flag2-fg"
            ];
            FLAG3_BG = [
              "Flag3 (Browse Cards List)"
              "#${config.lib.stylix.colors.base0A}"
              "#${config.lib.stylix.colors.base0A}"
              "--flag3-bg"
            ];
            FLAG3_FG = [
              "Flag3 (Browse Sidebar)"
              "#${config.lib.stylix.colors.base0B}"
              "#${config.lib.stylix.colors.base0B}"
              "--flag3-fg"
            ];
            FLAG4_BG = [
              "Flag4 (Browse Cards List)"
              "#${config.lib.stylix.colors.base0C}"
              "#${config.lib.stylix.colors.base0C}"
              "--flag4-bg"
            ];
            FLAG4_FG = [
              "Flag4 (Browse Sidebar)"
              "#${config.lib.stylix.colors.base0D}"
              "#${config.lib.stylix.colors.base0D}"
              "--flag4-fg"
            ];
            FLAG5_BG = [
              "Flag5 (Browse Cards List)"
              "#${config.lib.stylix.colors.base0E}"
              "#${config.lib.stylix.colors.base0E}"
              "--flag5-bg"
            ];
            FLAG5_FG = [
              "Flag5 (Browse Sidebar)"
              "#${config.lib.stylix.colors.base0F}"
              "#${config.lib.stylix.colors.base0F}"
              "--flag5-fg"
            ];
            FLAG6_BG = [
              "Flag6 (Browse Cards List)"
              "#${config.lib.stylix.colors.base08}"
              "#${config.lib.stylix.colors.base08}"
              "--flag6-bg"
            ];
            FLAG6_FG = [
              "Flag6 (Browse Sidebar)"
              "#${config.lib.stylix.colors.base09}"
              "#${config.lib.stylix.colors.base09}"
              "--flag6-fg"
            ];
            FLAG7_BG = [
              "Flag7 (Browse Cards List)"
              "#${config.lib.stylix.colors.base0A}"
              "#${config.lib.stylix.colors.base0A}"
              "--flag7-bg"
            ];
            FLAG7_FG = [
              "Flag7 (Browse Sidebar)"
              "#${config.lib.stylix.colors.base0B}"
              "#${config.lib.stylix.colors.base0B}"
              "--flag7-fg"
            ];
            FRAME_BG = [
              "Frame Background"
              "#${config.lib.stylix.colors.base00}"
              "#${config.lib.stylix.colors.base00}"
              "--frame-bg"
            ];
            HIGHLIGHT_BG = [
              "Highlighted Background"
              "#${config.lib.stylix.colors.base01}"
              "#${config.lib.stylix.colors.base01}"
              "--highlight-bg"
            ];
            HIGHLIGHT_FG = [
              "Highlighted Text"
              "#${config.lib.stylix.colors.base07}"
              "#${config.lib.stylix.colors.base07}"
              "--highlight-fg"
            ];
            LEARN_COUNT = [
              "Learn Count"
              "#${config.lib.stylix.colors.base09}"
              "#${config.lib.stylix.colors.base09}"
              "--learn-count"
            ];
            LINK = [
              "Hyperlink"
              "#${config.lib.stylix.colors.base0D}"
              "#${config.lib.stylix.colors.base0D}"
              "--link"
            ];
            MARKED_BG = [
              "Marked Background"
              "#${config.lib.stylix.colors.base0A}"
              "#${config.lib.stylix.colors.base0A}"
              "--marked-bg"
            ];
            MEDIUM_BORDER = [
              "Medium Border"
              "#${config.lib.stylix.colors.base03}"
              "#${config.lib.stylix.colors.base03}"
              "--medium-border"
            ];
            NEW_COUNT = [
              "New Count"
              "#${config.lib.stylix.colors.base0C}"
              "#${config.lib.stylix.colors.base0C}"
              "--new-count"
            ];
            REVIEW_COUNT = [
              "Review Count"
              "#${config.lib.stylix.colors.base0B}"
              "#${config.lib.stylix.colors.base0B}"
              "--review-count"
            ];
            SLIGHTLY_GREY_TEXT = [
              "Switch Text"
              "#${config.lib.stylix.colors.base04}"
              "#${config.lib.stylix.colors.base04}"
              "--slightly-grey-text"
            ];
            SUSPENDED_BG = [
              "Suspended Background"
              "#${config.lib.stylix.colors.base0E}"
              "#${config.lib.stylix.colors.base0E}"
              "--suspended-bg"
            ];
            SUSPENDED_FG = [
              "Suspended Foreground"
              "#${config.lib.stylix.colors.base0E}"
              "#${config.lib.stylix.colors.base0E}"
              "--suspended-fg"
            ];
            TEXT_FG = [
              "Text Foreground"
              "#${config.lib.stylix.colors.base05}"
              "#${config.lib.stylix.colors.base05}"
              "--text-fg"
            ];
            TOOLTIP_BG = [
              "Tooltip Background"
              "#${config.lib.stylix.colors.base01}"
              "#${config.lib.stylix.colors.base01}"
              "--tooltip-bg"
            ];
            WINDOW_BG = [
              "Window Background"
              "#${config.lib.stylix.colors.base00}"
              "#${config.lib.stylix.colors.base00}"
              "--window-bg"
            ];
            ZERO_COUNT = [
              "Zero Count"
              "#${config.lib.stylix.colors.base03}"
              "#${config.lib.stylix.colors.base03}"
              "--zero-count"
            ];
          };
          version = {
            major = 3;
            minor = 1;
          };
        };
      })
    ]))
  ];
}
