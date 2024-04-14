{ config, pkgs, lib, ... }:

{
  options.zathura = {
    enable = lib.mkEnableOption "Enables zathura";
  };

  config = lib.mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
