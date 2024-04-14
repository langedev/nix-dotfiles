{ config, pkgs, lib, ... }:

{
  options.git = {
    enable = lib.mkEnableOption "Enables git";
    username = lib.mkOption { default = config.home.username; };
    email = lib.mkOption {
      default = "git@" + config.home.username + ".com";
    };
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = config.git.username;
      userEmail = config.git.email;
    };
  };
}
