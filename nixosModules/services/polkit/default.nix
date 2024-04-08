{ config, pkgs, lib, ... }:

{
  options = {
    polkit.enable = lib.mkEnableOption "Enables polkit with kde handler";
  };

  config = lib.mkIf config.polkit.enable {
    security.polkit.enable = true;
    environment.systemPackages = with pkgs; [
      polkit-kde-agent
    ];
  }
}
