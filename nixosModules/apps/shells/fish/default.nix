{ config, pkgs, lib, ... }:

{
  options = {
    fish.enable = lib.mkEnableOption "Enables fish";
    fish.setDefault = lib.mkEnableOption
      "Sets fish as the default user's shell";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish.enable = true;
    users.defaultUserShell = lib.mkIf config.fish.setDefault pkgs.fish;
    environment.shells = with pkgs; [ fish ];
  };
}
