{ config, lib, ... }:

{
  config = lib.mkIf (config.shell.defaultShell == "xonsh") {
    programs.xonsh.enable = true;
  };
}
