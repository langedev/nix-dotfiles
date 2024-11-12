{ config, pkgs, lib, ... }:

{
  options.zoxide = {
    enable = lib.mkEnableOption "Enables Zoxide";
  };

  config = lib.mkIf config.zoxide.enable {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
