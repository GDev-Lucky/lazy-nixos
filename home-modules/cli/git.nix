{ config, lib, pkgs, options, ... }: with lib;

let
	cfg = config.git;
in
{
	options.git = {
		enable = mkOption { type = types.bool; default = false; };
		user = mkOption { type = types.str; default = "anon"; };
		email = mkOption { type = types.str; default = "anon@anon.com"; };
		remote = mkOption { type = types.str; default = "github"; };
	};

	config = mkMerge[
		(mkIf cfg.enable {
			programs.git = {
				enable = true;
				userName = cfg.user;
				userEmail = cfg.email;
				extraConfig = {
					init.defaultBranch = "main";
				};
			};
		})
	
		(mkIf (cfg.enable && cfg.remote == "github") {
			home.packages = [ pkgs.gh ];
			programs.git.extraConfig.credential.helper = "!gh auth git-credential";
		})
	];
}
