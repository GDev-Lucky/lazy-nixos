{ config, lib, pkgs, options, ... }: with lib;

{
	options.minimal = {
		enable = mkOption { type = types.bool; default = false; };
	};

	config = mkIf config.minimal.enable {
		environment.defaultPackages = [];
		documentation.enable = false;
		services.openssh.enable = false;
		environment.systemPackages = with pkgs; [ gcc git htop ];
	};

}
