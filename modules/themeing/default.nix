{ config, pkgs, lib, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      cascadia-code
      source-han-sans # Pan-CJK font
    ];
  };
}
