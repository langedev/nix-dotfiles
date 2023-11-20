{ config, pkgs, lib, ... }:

{
  users.users.pan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "network" ]; 
  };
}
