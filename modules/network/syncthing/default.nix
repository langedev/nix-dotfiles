{ config, pkgs, lib, ... }:

{
  services.syncthing = {
    enable = true;
    user = "pan";
    dataDir = "/home/pan/dox/Sync";
    configDir = "/home/pan/.config/syncthing";
    overrideFolders = true;
    overrideDevices = true;

    settings = {
      gui = {
        user = "pan";
        password = "password";
      };
    };
  };
}
