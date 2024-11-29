{ config, lib, ... }:

{
  config = lib.mkIf (config.shell.defaultShell == "zsh") {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      histFile = "$HOME/.config/zsh/history";
      histSize = 2000;
    };
  };
}
