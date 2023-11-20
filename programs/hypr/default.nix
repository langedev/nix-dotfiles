{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
      ${builtins.readFile ./default.conf}
      ${builtins.readFile ./keybinds.conf}
    '';
  home.packages = with pkgs; [
    socat # For hyprland scripts
    swww # Wallpaper engine
    wlr-randr # Xrandr for wayland
  ];
}
