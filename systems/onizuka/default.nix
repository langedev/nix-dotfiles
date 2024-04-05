{ config, pkgs, lib, ... }:

{
  networking.hostName = "onizuka";
  imports = [
    ./hardware.nix
    ../../modules/graphics/nvidia
    ../../modules/etc/steam
    ../../modules/etc/anime-launcher
    ../../modules/etc/input-remapper
  ];
}
