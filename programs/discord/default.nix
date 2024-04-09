{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    vesktop # Base app
  ];
}
