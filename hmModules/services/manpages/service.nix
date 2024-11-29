{ config, pkgs, lib, ... }:

{
  options.manpages = {
    enable = lib.mkEnableOption "Enables manpager";
  };

  config = lib.mkIf config.manpages.enable {
    programs.man.enable = true;
    home.packages = with pkgs; [
      man-pages
      man-pages-posix
    ];
  };
}
