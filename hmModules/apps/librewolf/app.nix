{ config, lib, ... }:

{
  options.librewolf = {
    enable = lib.mkEnableOption "Enables librewolf";
    make_default = lib.mkEnableOption "Makes librewolf the default browser";
  };

  config = lib.mkIf config.librewolf.enable {
    programs.librewolf.enable = true;
    home.sessionVariables = {
      BROWSER = "librewolf";
    };
    defaultApps.browser = lib.mkIf config.librewolf.make_default "librewolf";
  };
}
