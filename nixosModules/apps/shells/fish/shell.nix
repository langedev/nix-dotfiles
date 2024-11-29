{ config, lib, ... }:

{
  config = lib.mkIf (config.shell.defaultShell == "fish") {
    programs.fish.enable = true;
  };
}
