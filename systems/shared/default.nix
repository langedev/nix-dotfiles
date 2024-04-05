{ config, pkgs, ... }:
{
  nix.package = pkgs.nixUnstable;
  imports =
    [
      # System essentials (boot, lang, hostname, ...)
      ../../modules/audio/pipewire
      ../../modules/login/polkit
      ../../modules/system
      ../../modules/user

      ../../modules/shell/xonsh
      ../../modules/network/browsers/librewolf
      ../../modules/network/syncthing

      ../../modules/themeing
      ../../modules/login/greetd
      ../../modules/window_managers/hyprland
    ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05";
}
