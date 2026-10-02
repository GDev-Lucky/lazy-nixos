{ lib, ... }:

let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) anything attrsOf bool either lines listOf nullOr package str submodule;
in
{
  options.nvim = {
    enable = mkEnableOption "the local Nixvim wrapper";

    # Core

    defaultEditor = mkOption {
      type = bool;
      default = true;
      description = "Set EDITOR and VISUAL to nvim.";
    };

    aliases = {
      vi = mkOption {
        type = bool;
        default = false;
      };

      vim = mkOption {
        type = bool;
        default = false;
      };
    };

    leader = mkOption {
      type = str;
      default = " ";
    };

    localLeader = mkOption {
      type = str;
      default = "\\";
    };

    waylandSupport = mkOption {
      type = bool;
      default = false;
      description = "Enable Nixvim Wayland integration such as wl-clipboard.";
    };

    enableMan = mkOption {
      type = bool;
      default = false;
    };

    enablePrintInit = mkOption {
      type = bool;
      default = false;
    };

    providers = {
      node = mkOption {
        type = bool;
        default = false;
      };

      python3 = mkOption {
        type = bool;
        default = false;
      };

      ruby = mkOption {
        type = bool;
        default = false;
      };

      perl = mkOption {
        type = bool;
        default = false;
      };
    };

    # Editor configuration

    options = mkOption {
      type = attrsOf anything;
      default = { };
      description = "Values forwarded directly to programs.nixvim.opts.";
    };

    globalOptions = mkOption {
      type = attrsOf anything;
      default = { };
      description = "Values forwarded directly to programs.nixvim.globalOpts.";
    };

    localOptions = mkOption {
      type = attrsOf anything;
      default = { };
      description = "Values forwarded directly to programs.nixvim.localOpts.";
    };

    globals = mkOption {
      type = attrsOf anything;
      default = { };
      description = "Values forwarded directly to programs.nixvim.globals.";
    };

    env = mkOption {
      type = attrsOf anything;
      default = { };
    };

    extraPackages = mkOption {
      type = listOf package;
      default = [ ];
    };

    extraConfigLua = mkOption {
      type = lines;
      default = "";
    };

    extraConfigLuaPre = mkOption {
      type = lines;
      default = "";
    };

    extraConfigLuaPost = mkOption {
      type = lines;
      default = "";
    };

    extraConfigVim = mkOption {
      type = lines;
      default = "";
    };

    # Languages

    languages = mkOption {
      type = listOf str;
      default = [ ];
      description = "Language names from language-map.nix.";
    };

    languageFeatures = {
      lsp = mkOption {
        type = bool;
        default = true;
        description = "Configure mapped LSP servers when the lsp plugin is selected.";
      };

      treesitter = mkOption {
        type = bool;
        default = true;
        description = "Install mapped Tree-sitter grammars when treesitter is selected.";
      };

      highlight = mkOption {
        type = bool;
        default = true;
      };

      indent = mkOption {
        type = bool;
        default = false;
      };

      folding = mkOption {
        type = bool;
        default = false;
      };
    };

    # Plugins

    plugins = mkOption {
      type = listOf str;
      default = [ ];
      description = ''
        Exact Nixvim plugin attribute names to enable.
        Nothing is enabled by merely existing in this wrapper.
      '';
    };

    pluginOptions = mkOption {
      type = attrsOf (attrsOf anything);
      default = { };
      description = ''
        Direct plugin option overrides keyed by plugin name.
        Example: nvim.pluginOptions.telescope.extensions.fzf-native.enable = true;
      '';
    };

    pluginSettings = mkOption {
      type = attrsOf anything;
      default = { };
      description = ''
        Plugin setup/settings keyed by plugin name.
        Example: nvim.pluginSettings."neo-tree".close_if_last_window = true;
      '';
    };

    pluginKeymaps = mkOption {
      type = attrsOf anything;
      default = { };
      description = ''
        Native plugin keymap tables for plugins exposing a top-level keymaps option.
        Prefer nvim.keybinds for portable/global keybinds.
      '';
    };

    # Theme

    theme = mkOption {
      type = nullOr str;
      default = null;
      description = "Exact Nixvim colorscheme attribute name. Null installs no theme.";
    };

    themeSettings = mkOption {
      type = attrsOf anything;
      default = { };
    };

    # Keymaps

    keybinds = mkOption {
      type = attrsOf str;
      default = { };
      description = ''
        Simple normal-mode one-line mappings.
        Values can be symbolic actions from actions.nix or literal Neovim actions.
      '';
    };

    simpleKeymapOptions = mkOption {
      type = attrsOf anything;
      default = {
        silent = true;
      };
    };

    keymaps = mkOption {
      default = [ ];
      type = listOf (submodule {
        options = {
          key = mkOption {
            type = str;
          };

          action = mkOption {
            type = str;
          };

          mode = mkOption {
            type = either str (listOf str);
            default = "n";
          };

          desc = mkOption {
            type = nullOr str;
            default = null;
          };

          options = mkOption {
            type = attrsOf anything;
            default = { };
          };
        };
      });

      description = "Advanced mappings when the one-line keybind syntax is not enough.";
    };

    # Formatting

    formatters = mkOption {
      type = attrsOf anything;
      default = { };
      description = ''
        Filetype -> formatter mapping for conform-nvim.
        Only used when conform-nvim is explicitly selected.
      '';
    };

    formatOnSave = mkOption {
      type = nullOr anything;
      default = null;
      description = "conform-nvim format_on_save value.";
    };

    # Escape hatch

    raw = mkOption {
      type = attrsOf anything;
      default = { };
      description = ''
        Raw programs.nixvim configuration merged into the generated configuration.
        This is the escape hatch for anything the wrapper does not model.
      '';
    };
  };
}
