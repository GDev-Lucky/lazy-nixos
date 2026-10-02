# Neovim Home Manager wrapper

A thin wrapper around Nixvim intended for this repository.

The module is deliberately **opt-in**:

- `nvim.enable = true` enables Neovim/Nixvim.
- No theme is installed unless `nvim.theme` is set.
- No plugin is enabled unless its exact Nixvim plugin name appears in `nvim.plugins`.
- No language is enabled unless it appears in `nvim.languages`.
- Language LSP/Tree-sitter integration only activates when `"lsp"` / `"treesitter"` are also selected.
- Tree-sitter is forced to an empty grammar list before language selection, preventing Nixvim's default `allGrammars` behavior.
- Python, Ruby, Node and Perl providers default to off to keep the closure small.

## Install into this repo

Place this folder at:

```text
home-modules/neovim/
```

Your current `home-modules/bundle.nix` imports:

```nix
./cli/nixvim.nix
```

Replace that entry with:

```nix
./neovim
```

Then configure Neovim from your host `home.nix`.

## Minimal

```nix
nvim.enable = true;
```

That does not select any plugin, theme, language server, Tree-sitter grammar, or optional language provider.

## Typical setup

```nix
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

  languages = [ "nix" "rust" "c" ];

  options.number = true;

  keybinds = {
    "<leader>e" = "neo-tree.focus";
    "<leader>ff" = "telescope.find-files";
    "gl" = "diagnostic.float";
    "K" = "lsp.hover";
  };
};
```

## Plugins

`nvim.plugins` takes exact Nixvim plugin attribute names.

Examples:

```nix
nvim.plugins = [
  "treesitter"
  "lsp"
  "lspconfig"

  "cmp"
  "blink-cmp"
  "luasnip"

  "neo-tree"
  "oil"

  "telescope"
  "fzf-lua"

  "lualine"
  "bufferline"
  "web-devicons"
  "indent-blankline"

  "gitsigns"
  "fugitive"
  "diffview"

  "trouble"
  "todo-comments"
  "which-key"
  "flash"

  "nvim-autopairs"
  "nvim-surround"
  "treesitter-context"

  "conform-nvim"
  "none-ls"

  "dap"
  "neotest"
  "overseer"
  "harpoon"

  "noice"
  "notify"
  "render-markdown"
];
```

The wrapper does not maintain a closed plugin enum. This is intentional: any current/future Nixvim plugin can be selected without editing the wrapper. If a name is not a Nixvim plugin option in your pinned Nixvim revision, Nix will report the invalid option when you rebuild.

## Plugin configuration

Direct plugin options:

```nix
nvim.pluginOptions.telescope.extensions.fzf-native.enable = true;
```

Plugin `settings`:

```nix
nvim.pluginSettings."neo-tree" = {
  close_if_last_window = true;

  filesystem.follow_current_file = {
    enabled = true;
    leave_dirs_open = true;
  };
};
```

Native plugin keymaps, for plugins that expose a `keymaps` option:

```nix
nvim.pluginKeymaps.telescope = {
  "<leader>fg" = "live_grep";
  "<leader>fb" = "buffers";
};
```

The module refuses `pluginOptions`, `pluginSettings`, or `pluginKeymaps` for a plugin that is not in `nvim.plugins`.

## Simple keybinds

`nvim.keybinds` is normal mode and one line per binding:

```nix
nvim.keybinds = {
  "<leader>e" = "neo-tree.focus";
  "<leader>ff" = "telescope.find-files";
  "gl" = "diagnostic.float";
};
```

Values can be symbolic names from `actions.nix` or literal Neovim actions:

```nix
nvim.keybinds."<leader>w" = "<cmd>w<cr>";
```

For non-normal modes or custom options, use `nvim.keymaps`:

```nix
nvim.keymaps = [
  {
    mode = [ "n" "v" ];
    key = "<leader>y";
    action = ''"+y'';
    desc = "Copy to system clipboard";
  }
];
```

## Languages

`language-map.nix` maps language names to grammar(s) and LSP server(s).

Example:

```nix
nvim.languages = [
  "nix"
  "rust"
  "c"
  "cpp"
  "python"
  "typescript"
];
```

To get Tree-sitter grammar packages, select:

```nix
nvim.plugins = [ "treesitter" ];
```

To get language servers, select:

```nix
nvim.plugins = [ "lsp" ];
```

Usually you select both.

The package is explicitly overridden for the toolchain choices already established in this machine:

- Nix -> `pkgs.nixd`
- Rust -> `pkgs.rust-analyzer`
- C/C++/Objective-C -> `pkgs.llvmPackages.clang-tools` for `clangd`

Other mapped servers use Nixvim's package default.

Some less-common language servers vary across Nixvim revisions. A language only gets evaluated when you select it.

## Options

Any Neovim `vim.opt` value:

```nix
nvim.options = {
  number = true;
  relativenumber = true;
  cursorline = true;
  wrap = false;
  tabstop = 4;
  shiftwidth = 4;
  expandtab = false;
  ignorecase = true;
  smartcase = true;
};
```

You also have:

```nix
nvim.globalOptions = { };
nvim.localOptions = { };
nvim.globals = { };
nvim.env = { };
```

## Theme

Themes are also generic:

```nix
nvim.theme = "catppuccin";
```

This translates to the matching Nixvim colorscheme module:

```nix
programs.nixvim.colorschemes.catppuccin.enable = true;
```

Theme settings:

```nix
nvim.themeSettings = {
  flavour = "mocha";
};
```

No theme is installed when `nvim.theme = null`, which is the default.

## Completion example

nvim-cmp:

```nix
nvim.plugins = [ "cmp" "luasnip" ];

nvim.pluginOptions.cmp.autoEnableSources = true;

nvim.pluginSettings.cmp.sources = [
  { name = "nvim_lsp"; }
  { name = "buffer"; }
  { name = "path"; }
  { name = "luasnip"; }
];
```

Or use the alternative:

```nix
nvim.plugins = [ "blink-cmp" ];
```

and configure it through:

```nix
nvim.pluginSettings."blink-cmp" = { ... };
```

## Explorer alternatives

Neo-tree:

```nix
nvim.plugins = [ "neo-tree" ];
nvim.keybinds."<leader>e" = "neo-tree.focus";
```

Oil:

```nix
nvim.plugins = [ "oil" ];
nvim.keybinds."<leader>e" = "oil.open";
```

## Fuzzy finder alternatives

Telescope:

```nix
nvim.plugins = [ "telescope" ];
nvim.keybinds."<leader>ff" = "telescope.find-files";
```

fzf-lua:

```nix
nvim.plugins = [ "fzf-lua" ];
nvim.keybinds."<leader>ff" = "fzf-lua.files";
```

## Formatting

Select Conform:

```nix
nvim.plugins = [ "conform-nvim" ];

nvim.formatters = {
  rust = [ "rustfmt" ];
  c = [ "clang_format" ];
  nix = [ "nixfmt" ];
};

nvim.formatOnSave = {
  timeout_ms = 1000;
  lsp_format = "fallback";
};
```

The formatter executables themselves still need to be provided by a dev shell, the system, or `nvim.extraPackages`.

## Optional providers

They are intentionally disabled by default:

```nix
nvim.providers = {
  node = false;
  python3 = false;
  ruby = false;
  perl = false;
};
```

Enable one only when a selected plugin actually requires it.

Wayland support is also explicit:

```nix
nvim.waylandSupport = true;
```

## Raw escape hatch

If Nixvim supports something this wrapper does not model:

```nix
nvim.raw = {
  # Any programs.nixvim options.
};
```

This is intentionally unrestricted.

## Apply

For your current integrated Home Manager setup:

```bash
cd /etc/nixos
sudo nixos-rebuild test --flake .#nixos
```

Then restart Neovim.
