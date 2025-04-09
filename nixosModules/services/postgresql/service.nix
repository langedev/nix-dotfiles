{ config, lib, pkgs, ... }:

{
  options.postgres = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.postgres.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
      authentication = ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };
  };
}
