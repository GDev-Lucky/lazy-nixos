{ config, lib, ... }:

let
  cfg = config.nvim;
in
{
  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.nixvim = lib.mkMerge [
        {
          enable = true;

          viAlias = cfg.aliases.vi;
          vimAlias = cfg.aliases.vim;

          enableMan = cfg.enableMan;
          enablePrintInit = cfg.enablePrintInit;

          waylandSupport = cfg.waylandSupport;

          withNodeJs = cfg.providers.node;
          withPython3 = cfg.providers.python3;
          withRuby = cfg.providers.ruby;
          withPerl = cfg.providers.perl;

          globals = cfg.globals // {
            mapleader = cfg.leader;
            maplocalleader = cfg.localLeader;
          };

          opts = cfg.options;
          globalOpts = cfg.globalOptions;
          localOpts = cfg.localOptions;

          env = cfg.env;
          extraPackages = cfg.extraPackages;

          extraConfigLua = cfg.extraConfigLua;
          extraConfigLuaPre = cfg.extraConfigLuaPre;
          extraConfigLuaPost = cfg.extraConfigLuaPost;
          extraConfigVim = cfg.extraConfigVim;
        }

        cfg.raw
      ];
    }

    (lib.mkIf cfg.defaultEditor {
      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    })
  ]);
}
