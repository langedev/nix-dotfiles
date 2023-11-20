{ config, pkgs, lib, ... }:

{
  networking.hostName = "jibril";
  imports = [
    ./hardware/laptop.nix
    
    ./modules/network/networking
    ./modules/network/bluetooth
  ];
}
