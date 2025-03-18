{ config, pkgs, lib, ... }:

{
  options.caddy = {
    enable = lib.mkEnableOption "Enables caddy webserver";
    vhosts = lib.mkOption {};
    adminEmail = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf config.caddy.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.caddy = {
      enable = true;
      virtualHosts = config.caddy.vhosts;
      email = config.caddy.adminEmail;
    };
  };
}
