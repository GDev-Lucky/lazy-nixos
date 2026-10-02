{ pkgs, inputs, ... }:

{	
	imports = [
		inputs.home-manager.nixosModules.default
	] ++ import ../../modules/bundle.nix;

	# System settings
	system.stateVersion = "25.05";

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	networking.hostName = "nixos";

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	users.mutableUsers = true;

	programs.hyprland.enable = true;
	programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

	hardware.graphics.enable = true;

	hardware.nvidia.modesetting.enable = true;
	hardware.nvidia.open = true;
	services.xserver.videoDrivers = [ "nvidia" ];

	environment.systemPackages = [ pkgs.egl-wayland ];

	# System modules
	minimal.enable = true;
	programs.fish.enable = true;
	
	# Users
	users.users.root = {
		isNormalUser = false;
		createHome = false;
		shell = pkgs.fish;
	};

	users.users.lucky = {
		isNormalUser = true;
		createHome = true;
		shell = pkgs.fish;
		extraGroups = [ "wheel" ];
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		sharedModules = import ../../home-modules/bundle.nix;
		users = { lucky = import ./home.nix; };
	};


}
