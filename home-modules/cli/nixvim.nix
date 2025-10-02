{ pkgs,  inputs, ... }:

{
	imports = [ inputs.nixvim.homeModules.nixvim ];

	programs.nixvim = {
		enable =  true;

		#Theme
		colorscheme = "catppuccin";
		colorschemes.catppuccin.enable = true;

		# Keybinds
		globals.mapleader = " ";
		keymaps = [
			{ action = "<cmd>Neotree toggle<CR>"; key = "<leader>e"; }
		];

		# Plugins
		plugins.web-devicons = {
			enable = true;
		};

		plugins.treesitter = {
			enable = true;
			settings.ensure_installed = [ "nix" ];
		};

		plugins.lsp = {
			enable = true;
			servers.nixd = { enable = true; package = pkgs.nixd; };
		};

		plugins.luasnip = {
			enable = true;
			settings =  {
				lazy_load_vscode_snippets = true;
			};
		};

		plugins.neo-tree = {
			enable = true;
		};

		plugins.telescope = {
			enable = true;
			extensions.fzf-native.enable = true;
			keymaps."<leader>ff" = { action = "find_files"; options.desc = "Telescope: Find Files"; };
		};

		plugins.lualine = {
			enable = true;
		};

		plugins.cmp = {
			enable = true;
			autoEnableSources = true;
			settings.sources = [ {name = "nvim_lsp";} {name = "buffer";} {name = "path";} {name = "luasnip";} ];
		};
		
	};
}
