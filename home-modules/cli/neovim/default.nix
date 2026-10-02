{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim

    ./configs.nix
    ./options.nix
    ./plugins.nix
    ./languages.nix
    ./keymaps.nix
    ./themes.nix
    ./formatting.nix
  ];
}
