{ config, pkgs, lib, ... }:

{
  services.syncthing.enable = true;
  services.syncthing.user = "pan";
  services.syncthing.dataDir = "/home/pan/dox";
  services.syncthing.overrideFolders = false;
  services.syncthing.overrideDevices = false;
}
