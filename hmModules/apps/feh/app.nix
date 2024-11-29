{ config, lib, ... }:

{
  options.feh = {
    enable = lib.mkEnableOption "Enables feh";
  };

  config = lib.mkIf config.feh.enable {
    programs.feh = {
      enable = true;
    };
  };
}
