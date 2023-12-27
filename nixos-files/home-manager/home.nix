{ config, pkgs, inputs, ... }:

{
  home.username = "px";
  home.homeDirectory = "/home/px";
  home.stateVersion = "22.11";
  nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};
  imports = [
	inputs.hyprland.homeManagerModules.default
	./waybar.nix
	./gtk.nix
	./qutebrowser.nix
	./alacritty.nix
	./rofi.nix
	./git.nix
	./nvim.nix
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
	_1password-gui
	bat
	fzf
	ripgrep
	nerdfonts
	jq
	starship
	tree
	exa
	mako
	pciutils
	swaybg
	swaylock-effects
	pamixer
	pavucontrol
	pulseaudio
	inputs.hyprwm-contrib.packages.${system}.grimblast
	dracula-theme
	xdg-desktop-portal-gtk
	gsettings-desktop-schemas
	spotify
	wlogout
	glib
	feh
	];
  
	home.sessionVariables = {
		QT_QPA_PLATFORM = "wayland";
		MOZ_ENABLE_WAYLAND=1;
		GDK_BACKEND="wayland";
		EDITOR="nvim";
	};
	home.shellAliases = {
		l = "exa";
		ls = "exa";
		cat = "bat";
	};

	programs.zsh = {
		enable = true;
		initExtra = ''
			${pkgs.dt-shell-color-scripts}/bin/colorscript -e 22
			'';
	};

	programs.zsh.oh-my-zsh= {
		enable = true;
		plugins = ["git" "python" "docker" "fzf"];
		theme = "dpoggi";
	};

	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.system}.default;
		extraConfig = (import ./hyprland.nix); 
	};

	programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
		mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
	});	

	programs.firefox.enable = true;

		 
# Additional home files go here. 
#   home.file.".config/nvim/init.lua".source = ./init.lua;
}