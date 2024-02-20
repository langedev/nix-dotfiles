{ config, pkgs, lib, ... }:

{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = false;
    alsa.support32Bit = false;
    pulse.enable = true;
  };
}
