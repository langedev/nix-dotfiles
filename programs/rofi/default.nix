{ config, pkgs, ... }:

{
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;
  programs.wofi.settings = {
    show = "dmenu"; # Default to dmenu
    prompt = "";
    hide_scroll = true;
    insensitive = true;
    location = "bottom_right";
    dynamic_lines = true;
    yoffset = -100;
    xoffset = -40;
    height = "50%";
    width = "50%";
  };
  programs.wofi.style = ''
    window {
      background: rgba(0, 0, 0, 255);
      font-size: 4rem;
    }
    #entry, #input {
      margin: 2px;
      background: #FFFFFF;
      border-width: 2px;
      border-color: #000000;
    }
  '';
}
