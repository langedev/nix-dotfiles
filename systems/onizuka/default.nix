{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
  ];
  networking.hostName = "onizuka";
  nix.package = pkgs.nixUnstable;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  config = {
    nvidia.enable = true;
    pipewire.enable = true;
    polkit.enable = true;

    user.name = "pan";
    user.timezone = "America/Los_Angeles";

    tuigreet.enable = true;
    hyprland.enable = true;

    librewolf.enable = true;
    xonsh.enable = true;
    syncthing.enable = true;

    steam.enable = true;
    aagl.enable = true;
    aagl.honkai-rail = true;
    input-remapper.enable = true;
  };
}
