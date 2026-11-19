{inputs, ...}: {
  flake.nixosModules.desktop_obsidian = {
    config,
    pkgs,
    lib,
    ...
  }: let
    backup = config.custom.backup;
    vaultPath = "${config.home-manager.users.dastarruer.home.homeDirectory}/Documents/vault";
  in {
    custom.backup.backupPaths = lib.mkIf backup.enable [vaultPath];
    nixpkgs.overlays = [
      inputs.obsidian-extensions.overlays.default
    ];

    home-manager.users.dastarruer = {
      stylix.targets.obsidian = {
        enable = true;
        vaultNames = ["vault"];
      };

      programs.obsidian = {
        enable = true;
        vaults."vault" = {
          enable = true;
          target = "Documents/vault";
        };

        defaultSettings = {
          corePlugins = [
            "file-explorer"
            "global-search"
            "switcher"
            "command-palette"
          ];

          app = {
            promptDelete = false;
            newFileLocation = "current";
            attachmentFolderPath = "./";
          };

          communityPlugins = [
            {
              pkg = pkgs.obsidianPlugins.obsidian-linter;
              settings = {
                ruleConfigs = {
                  add-blank-line-after-yaml.enabled = true;

                  dedupe-yaml-array-values = {
                    enabled = true;
                    dedupe-alias-key = true;
                    dedupe-tag-key = true;
                    dedupe-array-keys = true;
                    ignore-keys = null;
                  };

                  escape-yaml-special-characters = {
                    enabled = true;
                    try-to-escape-single-line-arrays = true;
                  };

                  force-yaml-escape = {
                    enabled = true;
                    force-yaml-escape-keys = null;
                  };

                  format-tags-in-yaml.enabled = true;

                  format-yaml-array = {
                    enabled = true;
                    alias-key = true;
                    tag-key = true;
                    default-array-keys = true;
                    force-single-line-array-style = null;
                    force-multi-line-array-style = null;
                  };

                  insert-yaml-attributes = {
                    enabled = false;
                    text-to-insert = null;
                  };

                  move-inline-fields-to-yaml = {
                    enabled = true;
                    how-to-handle-full-line-fields = "Move and remove";
                    how-to-handle-bracketed-fields = "Leave in place";
                    how-to-handle-existing-keys = "Skip";
                    inline-keys-to-ignore = null;
                  };

                  move-tags-to-yaml = {
                    enabled = true;
                    how-to-handle-existing-tags = "Nothing";
                    tags-to-ignore = null;
                  };

                  remove-yaml-keys = {
                    enabled = false;
                    yaml-keys-to-remove = null;
                  };

                  sort-yaml-array-values = {
                    enabled = true;
                    sort-alias-key = true;
                    sort-tag-key = true;
                    sort-array-keys = true;
                    ignore-keys = null;
                    sort-order = "Ascending Alphabetical";
                  };

                  yaml-key-sort = {
                    enabled = true;
                    yaml-key-priority-sort-order = null;
                    priority-keys-at-start-of-yaml = true;
                    yaml-sort-order-for-other-keys = "None";
                  };

                  yaml-timestamp = {
                    enabled = false;
                    date-created = true;
                    date-created-key = "date created";
                    date-created-source-of-truth = "file system";
                    date-modified = true;
                    date-modified-key = "date modified";
                    date-modified-source-of-truth = "file system";
                    format = "dddd, MMMM Do YYYY, h:mm:ss a";
                    convert-to-utc = false;
                    update-on-file-contents-updated = "never";
                  };

                  yaml-title = {
                    enabled = false;
                    title-key = "title";
                    mode = "first-h1-or-filename-if-h1-missing";
                  };

                  yaml-title-alias = {
                    enabled = false;
                    preserve-existing-alias-section-style = true;
                    keep-alias-that-matches-the-filename = false;
                    use-yaml-key-to-keep-track-of-old-filename-or-heading = true;
                    alias-helper-key = "linter-yaml-title-alias";
                    remove-alias-if-empty = true;
                  };

                  capitalize-headings = {
                    enabled = true;
                    style = "Title Case";
                    ignore-case-words = true;
                    ignore-words = null;
                    lowercase-words = null;
                    starting-word-ignore-characters = "'\"(‘“-";
                    ending-word-ignore-characters = ".?!,:;'\")”’0123456789-";
                  };

                  file-name-heading.enabled = false;

                  header-increment = {
                    enabled = true;
                    start-at-h2 = true;
                  };

                  headings-start-line.enabled = true;

                  remove-trailing-punctuation-in-heading = {
                    enabled = true;
                    punctuation-to-remove = ".,;:!。，；：！";
                  };

                  footnote-after-punctuation.enabled = true;

                  move-footnotes-to-the-bottom = {
                    enabled = true;
                    include-blank-line-between-footnotes = true;
                  };

                  re-index-footnotes.enabled = true;

                  auto-correct-common-misspellings = {
                    enabled = false;
                    ignore-words = null;
                    skip-words-with-multiple-capitals = true;
                    extra-auto-correct-files = [];
                  };

                  blockquote-style = {
                    enabled = true;
                    style = "space";
                  };

                  convert-bullet-list-markers.enabled = true;

                  default-language-for-code-fences = {
                    enabled = false;
                    default-language = "";
                  };

                  emphasis-style = {
                    enabled = true;
                    style = "asterisk";
                  };

                  no-bare-urls = {
                    enabled = true;
                    no-bare-uris = true;
                  };

                  ordered-list-style = {
                    enabled = true;
                    number-style = "ascending";
                    list-end-style = ".";
                    preserve-start = true;
                  };

                  proper-ellipsis.enabled = true;

                  quote-style = {
                    enabled = true;
                    single-quote-enabled = true;
                    single-quote-style = "''";
                    double-quote-enabled = true;
                    double-quote-style = "\"\"";
                  };

                  remove-consecutive-list-markers.enabled = true;
                  remove-empty-list-markers.enabled = true;
                  remove-hyphenated-line-breaks.enabled = true;
                  remove-multiple-spaces.enabled = true;

                  strong-style = {
                    enabled = true;
                    style = "asterisk";
                  };

                  two-spaces-between-lines-with-content = {
                    enabled = false;
                    line-break-indicator = "  ";
                  };

                  unordered-list-style = {
                    enabled = true;
                    list-style = "-";
                  };

                  align-table-columns.enabled = true;

                  compact-yaml = {
                    enabled = true;
                    inner-new-lines = true;
                  };

                  consecutive-blank-lines.enabled = true;

                  convert-spaces-to-tabs = {
                    enabled = true;
                    tabsize = "2";
                  };

                  empty-line-around-blockquotes.enabled = true;
                  empty-line-around-code-fences.enabled = true;
                  empty-line-around-horizontal-rules.enabled = true;
                  empty-line-around-math-blocks.enabled = true;
                  empty-line-around-tables.enabled = true;

                  heading-blank-lines = {
                    enabled = true;
                    bottom = true;
                    empty-line-after-yaml = true;
                  };

                  line-break-at-document-end.enabled = true;
                  move-math-block-indicators-to-their-own-line.enabled = true;
                  paragraph-blank-lines.enabled = true;
                  remove-empty-lines-between-list-markers-and-checklists.enabled = true;
                  remove-link-spacing.enabled = true;

                  remove-space-around-characters = {
                    enabled = true;
                    include-fullwidth-forms = true;
                    include-cjk-symbols-and-punctuation = true;
                    include-dashes = true;
                    other-symbols = "";
                  };

                  remove-space-before-or-after-characters = {
                    enabled = true;
                    characters-to-remove-space-before = ",!?;:).’”]";
                    characters-to-remove-space-after = "¿¡‘“([";
                  };

                  space-after-list-markers.enabled = true;

                  space-between-chinese-japanese-or-korean-and-english-or-numbers = {
                    enabled = true;
                    english-symbols-punctuation-before = "-+;:'\"°%$)]";
                    english-symbols-punctuation-after = "-+'\"([¥$";
                  };

                  trailing-spaces = {
                    enabled = true;
                    two-space-line-break = false;
                  };

                  add-blockquote-indentation-on-paste.enabled = true;
                  prevent-double-checklist-indicator-on-paste.enabled = true;
                  prevent-double-list-item-indicator-on-paste.enabled = true;
                  proper-ellipsis-on-paste.enabled = true;
                  remove-hyphens-on-paste.enabled = true;
                  remove-leading-or-trailing-whitespace-on-paste.enabled = true;
                  remove-leftover-footnotes-from-quote-on-paste.enabled = true;
                  remove-multiple-blank-lines-on-paste.enabled = true;
                };

                lintOnSave = true;
                recordLintOnSaveLogs = false;
                displayChanged = true;
                suppressMessageWhenNoChange = true;
                enableDiffPreviewView = true;
                suppressLintAllFilesConfirmationModal = false;
                suppressLintAllFilesInFolderConfirmationModal = false;
                lintOnFileChange = true;
                ignoreFilesOutsideVault = false;
                displayLintOnFileChangeNotice = true;
                settingsConvertedToConfigKeyValues = true;
                textAreaSettingsConvertedToListItemSettings = true;
                defaultArrayStyleMovedToCommonStyles = true;
                additionalFileExtensions = [];
                foldersToIgnore = [];
                filesToIgnore = [];
                linterLocale = "system-default";
                logLevel = "ERROR";
                lintCommands = [];
                customRegexes = [];

                commonStyles = {
                  aliasArrayStyle = "single-line";
                  tagArrayStyle = "single-line";
                  defaultArrayStyle = "single-line";
                  minimumNumberOfDollarSignsToBeAMathBlock = 2;
                  escapeCharacter = "\"";
                  removeUnnecessaryEscapeCharsForMultiLineArrays = false;
                };
              };
            }
          ];

          hotkeys = {
            "obsidian-linter:lint-file" = [
              {
                modifiers = ["Mod" "Shift"];
                key = "I";
              }
            ];
            "editor:insert-footnote" = [
              {
                modifiers = ["Mod"];
                key = "0";
              }
            ];
            "switcher:open" = [
              {
                modifiers = ["Mod" "Shift"];
                key = "P";
              }
            ];
            "editor:toggle-source" = [
              {
                modifiers = ["Mod" "Shift"];
                key = "E";
              }
            ];
            "editor:toggle-bullet-list" = [
              {
                modifiers = ["Mod" "Shift"];
                key = "8";
              }
            ];
            "editor:set-heading-1" = [
              {
                modifiers = ["Alt" "Mod"];
                key = "1";
              }
            ];
            "editor:set-heading-2" = [
              {
                modifiers = ["Alt" "Mod"];
                key = "2";
              }
            ];
            "editor:set-heading-3" = [
              {
                modifiers = ["Alt" "Mod"];
                key = "3";
              }
            ];
            "editor:set-heading-4" = [
              {
                modifiers = ["Alt" "Mod"];
                key = "4";
              }
            ];
            "editor:set-heading-5" = [
              {
                modifiers = ["Alt" "Mod"];
                key = "5";
              }
            ];
            "editor:set-heading-6" = [
              {
                modifiers = ["Alt" "Mod"];
                key = "6";
              }
            ];
            "editor:swap-line-up" = [
              {
                modifiers = ["Alt"];
                key = "ArrowUp";
              }
            ];
            "editor:swap-line-down" = [
              {
                modifiers = ["Alt"];
                key = "ArrowDown";
              }
            ];
          };
        };
      };
    };
  };
}
