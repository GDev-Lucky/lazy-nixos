{ inputs, ... }:

{

	imports = [ inputs.zen-browser.homeModules.beta ];

	wayland.windowManager.hyprland = {
		enable = true;
		package = null;
		portalPackage = null;
	};

	programs.kitty.enable = true;

	programs.zen-browser.enable = true;

	wayland.windowManager.hyprland.settings = {
		monitor = [ ", 1920x1080@180, auto, auto" ];

		"$mod" = "SUPER";
		
		bindm = [
			"$mod, mouse:272, movewindow"
			"$mod, mouse:273, resizewindow"
			"$mod ALT, mouse272, resizewindow"
		];

		bind = [
			"$mod, Q, exec, kitty"
			"$mod, W, exec, zen"
			"$mod, C, killactive"
			"$mod, M, exit"
		] ++ (
        # workspaces
      	# binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      ); 
	};
}
