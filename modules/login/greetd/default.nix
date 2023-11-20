{ config, pkgs, lib, ... }:

{
  services.greetd = {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = {
      terminal = {
        vt = 2;
      };
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "pan";
      };
    };
  };
}
