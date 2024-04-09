{ config, pkgs, lib, ... }:

{
  options = {
    xonsh.enable = lib.mkEnableOption "Enables xonsh";
    xonsh.setDefault = lib.mkEnableOption
      "Sets xonsh as the default user's shell";
  };

  config = lib.mkIf config.xonsh.enable {
    programs.xonsh.enable = true;
    users.users.defaultUser.shell = lib.mkIf config.xonsh.setDefault pkgs.xonsh;
    environment.shells = with pkgs; [ xonsh ];
  };
}
