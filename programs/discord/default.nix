{ config, pkgs, ... }:
let rootPath = ./.; in
{
  home.packages = with pkgs; [
    discord # Base app
    betterdiscordctl # Better Discord Installer
  ];
  # Better Discord plugins
  xdg.configFile."better-discord" = {
    source = rootPath + "/plugins";
    target = "BetterDiscord/plugins";
  };
}
