{ config, pkgs, ... }:

{
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "Maldives";
  };
}