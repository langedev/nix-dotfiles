{ config, pkgs, ... }:

{
  programs.mpv.enable = true;
  programs.mpv.config = {
    volume-max = 150;
    force-window = "yes";
    script-opts = "ytdl_hook-ytdl_path=yt-dlp";
    ytdl-format = "bestvideo[height<=?1080][vcodec!=vp9]+bestaudio/best";
  };
  home.packages = with pkgs; [
    yt-dlp
  ];
}
