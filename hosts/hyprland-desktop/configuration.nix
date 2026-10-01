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

	users.mutableUsers = false;

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
		hashedPassword = "$6$j2vJATnI7wIg554R$i.cL4wYRPLMfTb0AY3sgSu9G7kwuDOrXl39JxBF4sgUY0IOH1lBUC3F68O6DguAsyQYl5OOU4fUKBodGEI2Uz0";

	};

	users.users.lucky = {
		isNormalUser = true;
		createHome = true;
		shell = pkgs.fish;
		hashedPassword = "$6$5i9sMO6rE4owcGe0$qKT6ZYHXbS6ZkbmmzXSj4quQvzpELHMoKDMeAa.6xsKoddRdcSacC010IoGq5cf3dut0YUjWCWvvNcfbdlM8H/";
		extraGroups = [ "wheel" ];
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = { limitedleaf = import ./home.nix; };
	};


}
