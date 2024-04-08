{ config, pkgs, lib, ... }:

{
  options = {
    steam.enable = lib.mkEnableOption "Enables steam";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
