{ config, pkgs, lib, ... }:

{
  options = {
    extraPkgs = lib.mkOption { default = []; };
    nvidia.enable = lib.mkEnableOption "Enables nvidia requirements";
    defaultApps = {
      terminal = lib.mkOption { default = ""; };
      browser = lib.mkOption { default = ""; };
    };
  };

  config = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.sessionVariables = {
      GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
      CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    };

    xdg = {
      enable = true;
      mimeApps.enable = true;
      userDirs = let
        home = config.home.homeDirectory;
      in {
        enable = true;
        documents   = "${home}/dox";
        publicShare = "${home}/dox/public";
        templates   = "${home}/dox/templates";
        music       = "${home}/med/mus";
        pictures    = "${home}/med/pix";
        videos      = "${home}/med/vid";
        desktop     = "${home}/dwn";
        download    = "${home}/dwn";
      };
    };

    home.homeDirectory = "/home/" + config.home.username;
    home.packages = config.extraPkgs;
  };
}
