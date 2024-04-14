{ config, pkgs, lib, ... }:

{
  options.mpv = {
    enable = lib.mkEnableOption "Enables mpv";
  };

  config = lib.mkIf config.mpv.enable {
    home.packages = with pkgs; [
      yt-dlp
    ];
    programs.mpv = {
      enable = true;
      config = {
        volume-max = 150;
        force-window = "yes";
        script-opts = "ytdl_hook-ytdl_path=yt-dlp";
        ytdl-format = "bestvideo[height<=?1080][vcodec!=vp9]+bestaudio/best";
      };
    };
  };
}
