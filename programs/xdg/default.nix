{ config, pkgs, ... }:

{
  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs = {
    desktop = "${config.home.homeDirectory}/dwn";
    download = "${config.home.homeDirectory}/dwn";
    documents = "${config.home.homeDirectory}/dox";
    publicShare = "${config.home.homeDirectory}/dox/public";
    templates = "${config.home.homeDirectory}/dox/templates";
    music = "${config.home.homeDirectory}/med/mus";
    pictures = "${config.home.homeDirectory}/med/pix";
    videos = "${config.home.homeDirectory}/med/vid";
  };
}
