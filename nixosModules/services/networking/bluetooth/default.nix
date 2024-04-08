{ config, pkgs, lib, ... }:

{
  options = {
    bluetooth.enable = lib.mkEnableOption "Enables Bluetooth with blueman";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    environment.systemPackages = with pkgs; [
      blueman
    ];
  };
}
