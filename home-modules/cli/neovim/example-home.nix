{
  nvim = {
    enable = true;

    theme = "catppuccin";

    plugins = [
      "web-devicons"
      "treesitter"
      "lsp"
      "luasnip"
      "neo-tree"
      "telescope"
      "lualine"
      "cmp"
    ];

    languages = [
      "nix"
      "rust"
      "c"
    ];

    options = {
      number = true;
      relativenumber = false;
      wrap = false;
      tabstop = 4;
      shiftwidth = 4;
    };

    keybinds = {
      "<leader>e" = "neo-tree.focus";
      "<leader>ff" = "telescope.find-files";
      "gl" = "diagnostic.float";
      "K" = "lsp.hover";
    };

    pluginOptions.telescope.extensions.fzf-native.enable = true;

    pluginOptions.cmp.autoEnableSources = true;

    pluginSettings.cmp.sources = [
      { name = "nvim_lsp"; }
      { name = "buffer"; }
      { name = "path"; }
      { name = "luasnip"; }
    ];
  };
}
