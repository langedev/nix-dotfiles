{ config, pkgs, ... }:
let rootPath = ./.; in
{
  home.packages = with pkgs; [
    xonsh
  ];
  home.sessionVariables = {
    PROMPT = "τ ";
    RIGHT_PROMPT = "{YELLOW}{gitstatus: {} }{BLUE}{short_cwd}{DEFAULT}";
    VI_MODE = 1;
  };
  xdg.configFile."xonshrc" = {
    source = rootPath + "/rc.xsh";
    target = "xonsh/rc.xsh";
  };

}
