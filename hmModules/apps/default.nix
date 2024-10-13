{ config, pkgs, ... }:

{
  imports = [
    ./chat
    ./file-browsers
    ./gimp
    ./git
    ./hypr
    ./librewolf
    ./lutris
    ./media-viewers
    ./neovim
    ./obs
    ./rofi
    ./shells
    ./terminal-emulators
    ./zoxide
  ];
}
