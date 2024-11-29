{ config, pkgs, lib, ... }:

{
  options.lutris = {
    enable = lib.mkEnableOption "Enables lutris";
  };

  config = lib.mkIf config.lutris.enable {
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
  };
}
