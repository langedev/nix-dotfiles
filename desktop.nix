{ config, pkgs, lib, ... }:

{
  networking.hostName = "onizuka";
  imports = [
    ./hardware/desktop.nix
      
    # ./modules/graphics/nvidia
  ];
}
