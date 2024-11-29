{ config, pkgs, lib, ... }:

{
  options.gimp = {
    enable = lib.mkEnableOption "Enables gimp";
  };

  config = lib.mkIf config.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
