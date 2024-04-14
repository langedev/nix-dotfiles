{ config, pkgs, lib, ... }:

{
  options.librewolf = {
    enable = lib.mkEnableOption "Enables librewolf";
  };

  config = lib.mkIf config.librewolf.enable {
    home.packages = with pkgs; [
      librewolf
    ];
    home.sessionVariables = {
      BROWSER = "librewolf";
    };
  };
}
