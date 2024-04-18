{ config, pkgs, lib, ... }:

{
  options.steam = {
    enable = lib.mkEnableOption "Enables steam";
    gamemode = lib.mkEnableOption "Enables gamemode";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    programs.gamemode.enable = true;
  };
}
