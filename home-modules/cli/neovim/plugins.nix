{ config, lib, ... }:

let
  cfg = config.nvim;

  selected = lib.unique cfg.plugins;

  configured =
    lib.unique (
      builtins.attrNames cfg.pluginOptions
      ++ builtins.attrNames cfg.pluginSettings
      ++ builtins.attrNames cfg.pluginKeymaps
    );

  configuredButDisabled =
    builtins.filter
      (name: !(builtins.elem name selected))
      configured;

  mkPlugin = name:
    let
      base =
        {
          enable = true;
        }
        // lib.optionalAttrs (name == "treesitter") {
          # Nixvim defaults to all grammars. Keep the wrapper minimal.
          grammarPackages = lib.mkDefault [ ];
        };

      withOptions =
        lib.recursiveUpdate
          base
          (cfg.pluginOptions.${name} or { });

      withSettings =
        if builtins.hasAttr name cfg.pluginSettings then
          lib.recursiveUpdate withOptions {
            settings = cfg.pluginSettings.${name};
          }
        else
          withOptions;

      withKeymaps =
        if builtins.hasAttr name cfg.pluginKeymaps then
          lib.recursiveUpdate withSettings {
            keymaps = cfg.pluginKeymaps.${name};
          }
        else
          withSettings;
    in
      lib.setAttrByPath [ name ] withKeymaps;
in
{
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = configuredButDisabled == [ ];
        message =
          "nvim: plugin configuration was supplied for disabled plugin(s): "
          + builtins.concatStringsSep ", " configuredButDisabled;
      }
    ];

    programs.nixvim.plugins =
      lib.mkMerge (map mkPlugin selected);
  };
}
