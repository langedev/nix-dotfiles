{ config, pkgs, lib, ... }:

{
  options.nnn = {
    enable = lib.mkEnableOption "Enables nnn";
  };

  config = lib.mkIf config.nnn.enable {
    programs.nnn.enable = true;
    home.sessionVariables = {
      NNN_FCOLORS = "0000E6310000000000000000";
      NNN_OPTS = "eH";
      NNN_FIFO = "/tmp/nnn.fifo";
      NNN_TRASH = lib.mkIf config.trash.enable "1";
    };
  };
}
