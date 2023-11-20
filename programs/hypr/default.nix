{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
      ${builtins.readFile ./default.conf}
      ${builtins.readFile ./keybinds.conf}
    '';
}
