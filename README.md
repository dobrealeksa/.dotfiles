# nixos-files

NixOS flakes and scripts. 

These flakes will install a basic NixOS with the following:

* Nix flakes + home manager
* Wayland + Hyprland Window Manager
* ZSH + Oh-my-ZSH
* 1Password
* Neovim
* Alacritty
* Qutebrowser
* Spotify
* Nerdfonts 
* Other goodies

You can clone this and use it with minimal changes. It *should* work.  

## Caveats:
- Change the hostname in `flake.nix` under the 2 FIXME comments. 
- Change the user account in `configuration.nix` or edit to your liking
- Change the home directory stuff in `home.nix`
- Overewrite the cloned `hardware-configuration.nix` with your own. 
- You might want to update the `flake.lock` file by running `nix flake update`  
- The rest should be okay!

## Usage
- Clone the repo, `cd nixos-files`
- To make the NixOS system: `sudo nixos-rebuild switch .#hostname` where `hostname` is what you set in `flake.nix`
- To make everything in home-manager: `home-manager switch .#username@hostname` where `username@hostname` is what you ser in `flake nix`
- Might want to reboot after that. 
- You will be dropped into a TTY, as Hyprland doesn't really come with a Display Manager. Simply log in, and run `Hyprland`
- To get out of Hyprland, `SUPER+SHIFT Q` where `SUPER` is usually the Windows Key / Option Key. 

---
## Preview
![Screenshot](./screenshot.png "Screenshot")