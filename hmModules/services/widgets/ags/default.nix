{ config, inputs, pkgs, lib, ... }:
{

  options.ags = {
    enable = lib.mkEnableOption "Enable ags";
  };

  imports = [ inputs.ags.homeManagerModules.default ];

  config = lib.mkIf config.ags.enable {
    home.packages = with pkgs; [
      libnotify # Notifications through ags
    ];
    programs.ags = {
      enable = true;
      configDir = ./config;

      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}
