{ config, lib, ... }:

{
  options.input-remapper = {
    enable = lib.mkEnableOption "Enables input-remapper";
  };

  config = lib.mkIf config.input-remapper.enable {
    services.input-remapper.enable = true;
  };
}
