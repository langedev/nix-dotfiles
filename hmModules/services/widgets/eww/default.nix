{ config, pkgs, lib, ... }:

{
  options.eww = {
    enable = lib.mkEnableOption "Enables eww";
  };

  config = lib.mkIf config.eww.enable {
    programs.eww.enable = true;
    programs.eww.package = pkgs.eww-wayland;
    programs.eww.configDir = ./config;
  };
}
