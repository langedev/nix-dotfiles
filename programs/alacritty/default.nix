{ config, pkgs, ... }:

{
  programs.alacritty.enable = true;


  programs.alacritty.settings = {
    font = let fam = "Cascadia Code"; in {
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
      size = 24.0;
    };
  };
}
