{ config, pkgs, lib, ... }:

{
  options = {
    librewolf.enable = lib.mkEnableOption "Enables librewolf";
  };

  config = lib.mkIf config.librewolf.enable {
    environment.variables.BROWSER = "librewolf";
    environment.systemPackages = with pkgs; [ librewolf ];
  };
}
