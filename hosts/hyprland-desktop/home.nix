{ config, lib, pkgs, ... }:

{	
	imports = import ../../home-modules/bundle.nix;

	home.username = "limitedleaf";
	home.homeDirectory = "/home/limitedleaf";
	home.stateVersion = "25.05";	
	programs.home-manager.enable = true;

	# Enable modules 

	git.enable = true;
	git.user = "limitedleaf";
	git.email = "limitedleaf7@gmail.com";
}
