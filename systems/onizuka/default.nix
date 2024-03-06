{ config, pkgs, lib, ... }:

{
  networking.hostName = "onizuka";
  imports = [
    ./hardware.nix
    ../../modules/graphics/nvidia
    ../../modules/etc/steam
  ];
}
