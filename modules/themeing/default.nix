{ config, pkgs, lib, ... }:

{
  fonts.packages = with pkgs; [
    cascadia-code
  ];
}
