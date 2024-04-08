{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
  ];
  networking.hostName = "jibril";
  nix.package = pkgs.nixUnstable;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  config = {
    pipewire.enable = true;
    polkit.enable = true;
    bluetooth.enable = true;
    wireless.enable = true;

    user.name = "pan";
    user.timezone = "America/Los_Angeles";

    tuigreet.enable = true;
    hyprland.enable = true;

    librewolf.enable = true;
    xonsh.enable = true;
    syncthing.enable = true;
  };
}
