{ config, lib, pkgs, ... }:

{
	imports = import ../../home-modules/bundle.nix;

	home.username = "lucky";
	home.homeDirectory = "/home/lucky";
	home.stateVersion = "25.05";

	programs.home-manager.enable = true;

# Git

	git.enable = true;
	git.user = "GDev-Lucky";
	git.email = "gdevlucky@gmail.com";

# Neovim
	
		

	nvim = {
		enable = true;

		languages = [
			"nix"
		];

		plugins = [
			"lsp"
				"cmp"
				"neo-tree"
				"cmp-nvim-lsp"
		];

		keybinds = {
			"<leader>e" = "neo-tree.focus";
			"<leader>E" = "neo-tree.toggle";
			"<leader>r" = "neo-tree.reveal";
		};

		pluginOptions.cmp.autoEnableSources = true;

		pluginSettings.cmp.sources = [
		{ name = "nvim_lsp"; }
		{ name = "buffer"; }
		{ name = "path"; }
		];
	};

}
