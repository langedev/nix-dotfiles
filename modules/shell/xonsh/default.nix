{ config, pkgs, lib, ... }:

{
  programs.xonsh.enable = true;

  users.defaultUserShell = pkgs.xonsh;

  environment.shells = with pkgs; [ xonsh ];
}
