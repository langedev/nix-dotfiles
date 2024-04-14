{ config, pkgs, lib, ... }:

{
  options.dunst = {
    enable = lib.mkEnableOption "Enables dunst";
  };

  config = lib.mkIf config.dunst.enable {
    home.packages = with pkgs; [
      libnotify
    ];
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 280;
          height = 240;
          origin = "bottom-right";
          offset = "0x300";

          notification_limit = 3;

          progress_bar_max_width = 280;

          gap_size = 4;
          corner_radius = 20;
        };

        urgency_low = {
          background = "#FFFFFFCC";
          foreground = "#000000";
          frame_color = "#0000";
        };

        urgency_normal = {
          background = "#FFFFFFCC";
          foreground = "#000000";
          frame_color = "#0000";
        };

        urgency_critical = {
          background = "#FFFFFFCC";
          foreground = "#000000";
          frame_color = "#0000";
        };
      };
    };
  };
}
