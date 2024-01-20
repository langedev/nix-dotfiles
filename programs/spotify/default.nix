{ config, pkgs, ... }:

{
  services.spotifyd.enable = true;
  services.spotifyd.settings = {
    global = {
      username = "me@daltonlange.com";
      password = "5ThM^G3!FTfH6rH#cJEx";
      backend = "pulseaudio";
      device_name = "onizuka";
      bitrate = 320;
    };
  };

  home.packages = with pkgs; [
    spotify-tui # Spotify TUI player
  ];
}
