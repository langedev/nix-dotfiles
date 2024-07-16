{ config, inputs, pkgs, lib, ... }:
let rootPath = ./.; in
{
  options.hypr = {
    enable = lib.mkEnableOption "Enables hyprland";
  };

  imports = [ inputs.hyprland.homeManagerModules.default ];

  config = {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  } // lib.mkIf config.hypr.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        ${builtins.readFile ./window_rules.conf}
        ${builtins.readFile ./league_rules.conf}
        ${builtins.readFile ./settings.conf}
        ${builtins.readFile ./nvidia.conf}
        ${builtins.readFile ./keybinds.conf}
        ${builtins.readFile ./xwaylandvideobridge.conf}
        exec-once=${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1

        env = HYPRCURSOR_THEME,miku
        env = HYPRCURSOR_SIZE,64
      '';
    };
    home.packages = with pkgs; [
      socat # For hyprland scripts
      swww # Wallpaper engine
      wlr-randr # Xrandr for wayland
      wl-clipboard # Clipboard manager for wayland
      xdg-desktop-portal-hyprland # XDP for hyprland
      hyprpicker # Colorpicker, needed for screenshot tool
      hyprcursor # Hyprland cursor
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Screenshot tool
      xonsh
      polkit-kde-agent # Polkit handler
    ];
    # Hyprland screenshot tool
    xdg.configFile."hypr-scripts" = {
      source = rootPath + "/scripts";
      target = "hypr/scripts";
      executable = true;
    };

    xdg.dataFile."hypr-icons" = {
      source = rootPath + "/icons";
      target = "icons/";
      recursive = true;
    };
  };
}
