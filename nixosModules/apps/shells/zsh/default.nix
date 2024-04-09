{ config, pkgs, lib, ... }:

{
  options = {
    zsh.enable = lib.mkEnableOption "Enables zsh";
    zsh.setDefault = lib.mkEnableOption "Sets zsh as the default user's shell";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      histFile = "$HOME/.config/zsh/history";
      histSize = 2000;
    };
    users.users.defaultUser.shell = lib.mkIf config.zsh.setDefault pkgs.zsh;
    environment.shells = with pkgs; [ zsh ];
  };
}
