{ config, pkgs, lib, ... }:

{
  options.pipewire = {
    enable = lib.mkEnableOption "Enables pipewire and pulsemixer";
  };

  config = lib.mkIf config.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = false;
      alsa.support32Bit = false;
      pulse.enable = true;
    };
    environment.systemPackages = with pkgs; [
      pulsemixer
    ];
  };
}
