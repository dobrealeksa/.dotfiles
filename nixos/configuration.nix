 {config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./greetd.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.extraModprobeConfig = ''
      options hid_apple fnmode=1
  '';
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "hid-apple"  ];  

  # Enable Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    '';

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.px = {
    isNormalUser = true;
    description = "PX";
	initialPassword = "321"
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  neovim
  git
  python3Minimal
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # }; 

# --- Comments start here --- Old Xserver & Awesome WM stuff. 
#   services.xserver.enable = true;
#   # services.xserver.displayManager.lightdm.enable = true;
#   services.xserver.desktopManager = {
#         xfce = {
#           enable = true;
#           noDesktop = true;
#           enableXfwm = false;
#         };
#       };
#   services.xserver.windowManager.awesome.enable = true;
#   services.xserver.libinput.enable = true;
#   # List services that you want to enable:
#   services.pipewire = {
#   	enable = true;
# 	alsa.enable = true;
# 	alsa.support32Bit = true;
# 	pulse.enable = true;
# 	};
# --- Comments end here --- 
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

  # services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.prime = {
    sync.enable = true;

  #   # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #   nvidiaBusId = "PCI:1:0:0";

  #   # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
  #   intelBusId = "PCI:0:2:0";
  # };
}
