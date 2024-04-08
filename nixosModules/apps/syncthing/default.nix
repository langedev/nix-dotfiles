{ config, pkgs, lib, ... }:

{
  options = {
    syncthing.enable = lib.mkEnableOption "Enables syncthing";
  };

  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = config.user.name;
      dataDir = "/home/" + config.user.name + "/dox/Sync";
      configDir = "/home/" + config.user.name + "/.config/syncthing";
      overrideFolders = true;
      overrideDevices = true;

      settings = {
        gui = {
          user = config.user.name;
          password = "password";
        };
      };
    };
  };
}
