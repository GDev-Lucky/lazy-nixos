{ config, lib, ... }:

let
  cfg = config.nvim;

  themeConfig =
    {
      enable = true;
    }
    // lib.optionalAttrs (cfg.themeSettings != { }) {
      settings = cfg.themeSettings;
    };
in
{
  config =
    lib.mkIf (cfg.enable && cfg.theme != null) {
      programs.nixvim = {
        colorscheme = cfg.theme;

        colorschemes =
          lib.setAttrByPath
            [ cfg.theme ]
            themeConfig;
      };
    };
}
