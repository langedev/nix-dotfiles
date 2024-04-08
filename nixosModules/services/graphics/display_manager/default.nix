{ config, pkgs, lib, ... }:

{
  options = {
    tuigreet.enable = lib.mkEnableOption "enables tuigreet with greetd";
  };

  config = lib.mkIf config.tuigreet.enable {
    services.greetd = {
      enable = true;
      package = pkgs.greetd.tuigreet;
      settings = {
        terminal = {
          vt = 2;
        };
        default_session = lib.mkIf config.hyprland.enable {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = config.user.name;
        };
      };
    };
  };
}
