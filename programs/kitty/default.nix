{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Cascadia Code";
      font_size = 18;
      enable_audio_bell = "no";
    };
  };
}
