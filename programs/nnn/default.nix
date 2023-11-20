{ config, pkgs, ... }:

{
  programs.nnn.enable = true;
  home.sessionVariables = {
    NNN_FCOLORS = "0000E6310000000000000000";
    NNN_OPTS = "eH";
    NNN_FIFO = "/tmp/nnn.fifo";
    NNN_TRASH = "1";
  };
}
