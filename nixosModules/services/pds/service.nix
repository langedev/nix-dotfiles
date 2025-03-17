{ config, pkgs, lib, ... }:

{
  options.pds = {
    enable = lib.mkEnableOption "Enables atproto Personal Data Server";
    hostname = lib.mkOption { type = lib.types.str; };
    adminEmail = lib.mkOption { type = lib.types.str; };
    environmentFile = lib.mkOption { type = lib.types.path; };
  };

  config = lib.mkIf config.pds.enable {
    services.pds = {
      enable = true;
      environmentFiles = [ config.pds.environmentFile ];
      settings = {
        PDS_HOSTNAME = config.pds.hostname;
        PDS_ADMIN_EMAIL = config.pds.adminEmail;
      };
    };
  };
}
