{ config, lib, pkgs, options, ... }: with lib;

{
	options.minimal = {
		enable = mkOption { type = types.bool; default = false; };
	};

	config = mkIf config.minimal.enable {
		environment.defaultPackages = [];
		environment.systemPackages = with pkgs; [ gcc git htop ];

		services.openssh.enable = false;
		services.lvm.enable = false;
		services.printing.enable = false;
		services.avahi.enable = false;
		services.gvfs.enable = false;
		
		boot.bcache.enable = false;

		programs.nano.enable = false;
		programs.command-not-found.enable = false;
		
		documentation.enable = false;
		documentation.man.enable = false;
		documentation.info.enable = false;
		documentation.nixos.enable = false;
		documentation.doc.enable = false;
		
	};

}
