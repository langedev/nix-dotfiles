{ config, pkgs, lib, ... }:

{
  options.alacritty = {
    enable = lib.mkEnableOption "Enables alacritty";
    font = lib.mkOption { default = ""; };
    font_size = lib.mkOption { default = 18; };
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty.enable = true;

    programs.alacritty.settings = {
      font = let fam = config.alacritty.font; in {
        normal = {
          family = fam;
          style = "Regular";
        };
        bold = {
          family = fam;
          style = "Bold";
        };
        italic = {
          family = fam;
          style = "Italic";
        };
        bold_italic = {
          family = fam;
          style = "Bold Italic";
        };
        offset = {
          x = 0;
          y = 0;
        };
        size = config.alacritty.font_size;
      };
    };
  };
}
