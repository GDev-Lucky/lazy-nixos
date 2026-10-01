{ config, lib, pkgs, ... }:

{	
	imports = import ../../home-modules/bundle.nix;

	home.username = "lucky";
	home.homeDirectory = "/home/lucky";
	home.stateVersion = "25.05";	
	programs.home-manager.enable = true;

	# Enable modules 

	git.enable = true;
	git.user = "GDev-Lucky";
	git.email = "gdevlucky@gmail.com";
}
