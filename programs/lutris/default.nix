{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    wineWowPackages.stable
    # (lutris.override {
    #   extraLibraries = pkgs: [
    #     # List library dependencies here
    #   ];
    #   extraPkgs = pkgs: [
    #     # List package dependencies here
    #   ];
    # })
  ];
}
