{ config, pkgs, lib, ... }:
{
  options.obs = {
    enable = lib.mkEnableOption "Enables obs";
  };

  config = lib.mkIf config.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };
}
