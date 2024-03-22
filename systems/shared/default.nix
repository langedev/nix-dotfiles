# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  nix.package = pkgs.nixUnstable;
  imports =
    [
      # System essentials (boot, lang, hostname, ...)
      ../../modules/system

      ../../modules/user

      ../../modules/themeing

      ../../modules/audio/pipewire

      ../../modules/shell/xonsh
      ../../modules/network/browsers/librewolf
      ../../modules/network/syncthing

      ../../modules/login/greetd
      ../../modules/window_managers/hyprland
    ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05";
}
