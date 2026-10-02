{ config, lib, ... }:

let
  cfg = config.nvim;

  configured =
    cfg.formatters != { }
    || cfg.formatOnSave != null;

  enabled =
    builtins.elem "conform-nvim" cfg.plugins;
in
{
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = !configured || enabled;
        message = "nvim: formatters/formatOnSave require 'conform-nvim' in nvim.plugins";
      }
    ];

    programs.nixvim.plugins."conform-nvim".settings =
      lib.mkIf enabled (
        lib.optionalAttrs (cfg.formatters != { }) {
          formatters_by_ft = cfg.formatters;
        }
        // lib.optionalAttrs (cfg.formatOnSave != null) {
          format_on_save = cfg.formatOnSave;
        }
      );
  };
}
