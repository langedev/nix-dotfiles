{ config, pkgs, ... }:
let rootPath = ./.; in
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
      ${builtins.readFile ./default.conf}
      ${builtins.readFile ./keybinds.conf}
    '';
  # wayland.windowManager.hyprland.enableNvidiaPatches = true;
  home.packages = with pkgs; [
    socat # For hyprland scripts
    swww # Wallpaper engine
    wlr-randr # Xrandr for wayland
    xdg-desktop-portal-hyprland # XDP for hyprland
  ];
  xdg.configFile."hypr-scripts" = {
    source = rootPath + "/scripts";
    target = "hypr/scripts";
    executable = true;
  };
}
