{ config, pkgs, lib, ... }:

{
  networking.hostName = "jibril";
  imports = [
    ./hardware.nix

    ../../modules/network/bluetooth
    ../../modules/network/networking
  ];
}
