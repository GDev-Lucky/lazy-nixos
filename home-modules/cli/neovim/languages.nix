{ config, lib, pkgs, ... }:

let
  cfg = config.nvim;

  languageMap = import ./language-map.nix {
    inherit pkgs;
  };

  unknownLanguages =
    builtins.filter
      (name: !(builtins.hasAttr name languageMap))
      cfg.languages;

  knownLanguages =
    builtins.filter
      (name: builtins.hasAttr name languageMap)
      (lib.unique cfg.languages);

  selected =
    map
      (name: languageMap.${name})
      knownLanguages;

  useTreesitter =
    cfg.languageFeatures.treesitter
    && builtins.elem "treesitter" cfg.plugins;

  useLsp =
    cfg.languageFeatures.lsp
    && builtins.elem "lsp" cfg.plugins;

  grammarNames =
    lib.unique (
      lib.concatMap
        (language: language.grammars or [ ])
        selected
    );

  grammars =
    config.programs.nixvim.plugins.treesitter.package.builtGrammars;

  grammarPackages =
    map
      (
        name:
        if builtins.hasAttr name grammars then
          builtins.getAttr name grammars
        else
          throw "nvim: Tree-sitter grammar '${name}' is not available in this Nixvim revision"
      )
      grammarNames;

  serverConfigs =
    lib.foldl'
      lib.recursiveUpdate
      { }
      (
        map
          (
            language:
            lib.mapAttrs
              (_: serverConfig:
                lib.recursiveUpdate
                  { enable = true; }
                  serverConfig
              )
              (language.servers or { })
          )
          selected
      );
in
{
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = unknownLanguages == [ ];
        message =
          "nvim: unknown language(s): "
          + builtins.concatStringsSep ", " unknownLanguages;
      }
    ];

    programs.nixvim.plugins.treesitter =
      lib.mkIf useTreesitter {
        enable = true;
        grammarPackages = grammarPackages;

        settings.highlight.enable = cfg.languageFeatures.highlight;
        settings.indent.enable = cfg.languageFeatures.indent;
        folding = cfg.languageFeatures.folding;
      };

    programs.nixvim.plugins.lsp =
      lib.mkIf useLsp {
        enable = true;
        servers = serverConfigs;
      };
  };
}
