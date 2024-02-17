{ inputs, pkgs, ... }:
let rootPath = ./.; in
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
      ${builtins.readFile ./window_rules.conf}
      ${builtins.readFile ./settings.conf}
      ${builtins.readFile ./nvidia.conf}
      ${builtins.readFile ./keybinds.conf}
      ${builtins.readFile ./xwaylandvideobridge.conf}
    '';
  # wayland.windowManager.hyprland.enableNvidiaPatches = true;
  home.packages = with pkgs; [
    socat # For hyprland scripts
    swww # Wallpaper engine
    wlr-randr # Xrandr for wayland
    wl-clipboard # Clipboard manager for wayland
    xdg-desktop-portal-hyprland # XDP for hyprland
    hyprpicker # Colorpicker, needed for screenshot tool
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Screenshot tool
    xwaylandvideobridge # Allows screensharing with xwayland apps
  ];
  # Hyprland screenshot tool
  xdg.configFile."hypr-scripts" = {
    source = rootPath + "/scripts";
    target = "hypr/scripts";
    executable = true;
  };
}
