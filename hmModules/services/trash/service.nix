{ pkgs, lib, ... }:

{
  options.trash = {
    enable = lib.mkEnableOption "Enables trash";
  };

  config = {
    home.packages = [
      pkgs.trash-cli
    ];
  };
}
