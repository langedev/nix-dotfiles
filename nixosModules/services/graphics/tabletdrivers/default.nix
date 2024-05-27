{ config, pkgs, lib, ... }:

{
  options = {
    tablet.enable = lib.mkEnableOption
      "Enables tablet support";
  };

  config = lib.mkIf config.tablet.enable {
    hardware.opentabletdriver.enable = true;
    environment.systemPackages = with pkgs; [
      opentabletdriver
    ];
  };
}
