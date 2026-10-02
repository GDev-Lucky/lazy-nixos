{ config, lib, ... }:

let
  cfg = config.nvim;

  actionMap = import ./actions.nix;

  resolveAction = action:
    if builtins.hasAttr action actionMap then
      builtins.getAttr action actionMap
    else
      action;

  simpleKeymaps =
    lib.mapAttrsToList
      (
        key: action:
        {
          mode = "n";
          inherit key;
          action = resolveAction action;

          options =
            cfg.simpleKeymapOptions
            // {
              desc =
                if builtins.hasAttr action actionMap then
                  action
                else
                  "custom";
            };
        }
      )
      cfg.keybinds;

  advancedKeymaps =
    map
      (
        mapping:
        {
          inherit (mapping) key mode;
          action = resolveAction mapping.action;

          options =
            mapping.options
            // lib.optionalAttrs (mapping.desc != null) {
              desc = mapping.desc;
            };
        }
      )
      cfg.keymaps;
in
{
  config = lib.mkIf cfg.enable {
    programs.nixvim.keymaps =
      simpleKeymaps
      ++ advancedKeymaps;
  };
}
