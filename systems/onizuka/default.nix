{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
  ];
  networking.hostName = "onizuka";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  nvidia.enable = true;
  pipewire.enable = true;
  polkit.enable = true;
  tablet.enable = true;

  user.name = "pan";
  user.timezone = "America/Los_Angeles";
  system.doAutoUpgrade = true;

  tuigreet.enable = true;
  hyprland.enable = true;

  librewolf.enable = true;
  fish.enable = true;
  fish.setDefault = true;
  syncthing.enable = true;

  steam.enable = true;
  steam.gamemode.enable = true;
  aagl.enable = true;
  aagl.honkai-rail = true;
  input-remapper.enable = true;
}
