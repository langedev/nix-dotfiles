# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  systemType = "laptop";
  #systemType = "desktop";
in {
  nix.package = pkgs.nixUnstable;
  imports =
    [ 
      # Hardware Specific Configuration
      ./${systemType}.nix

      # System essentials (boot, lang, hostname, ...)
      ./modules/system

      ./modules/user

      ./modules/themeing

      ./modules/audio/pipewire

      ./modules/shell/fish # This enables fish as the default shell
      ./modules/network/browsers/librewolf
      ./modules/network/syncthing
      
      ./modules/login/greetd
    ];

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "23.05";
}
