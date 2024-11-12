{ config, pkgs, lib, ... }:

{
  options.rofi = {
    enable = lib.mkEnableOption "Enables rofi";
  };

  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}
