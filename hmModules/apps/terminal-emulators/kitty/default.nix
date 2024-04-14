{ config, pkgs, lib, ... }:

{
  options.kitty = {
    enable = lib.mkEnableOption "Enables kitty";
    font = lib.mkOption { default = ""; };
    font_size = lib.mkOption { default = 18; };
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        font_family = config.kitty.font;
        font_size = config.kitty.font_size;
        enable_audio_bell = "no";
      };
    };
  };
}
