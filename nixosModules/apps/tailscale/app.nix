{ config, lib, ... }:

{
  options.tailscale = {
    enable = lib.mkEnableOption "Enables tailscale";
  };

  config = lib.mkIf config.tailscale.enable {
    services.tailscale.enable = true;
  };
}
