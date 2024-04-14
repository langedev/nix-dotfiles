{ config, pkgs, lib, ... }:

{
  options.beeper = {
    enable = lib.mkEnableOption "Enables beeper";
  };

  config = lib.mkIf config.beeper.enable {
    home.packages = with pkgs; [
      beeper
    ];
  };
}
