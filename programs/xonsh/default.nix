{ config, pkgs, ... }:

{
  programs.xonsh.enable = true;

  programs.xonsh.interactiveShellInit = ''
      cat ~/.cache/wal/sequences
    '';

    home.sessionVariables = {
      PROMPT = "τ ";
      RIGHT_PROMPT = "{YELLOW}{gitstatus: {} }{BLUE}{short_cwd}{DEFAULT}";
      VI_MODE = 1;
  };
}
