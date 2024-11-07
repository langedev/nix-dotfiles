{ config, pkgs, lib, ... }:

{
  options = {
    wireless = {
      enable = lib.mkEnableOption "Enables wireless";
      networks = lib.mkOption { default = {}; };
      secretsFile = lib.mkOption {};
    };
  };

  config = lib.mkIf config.wireless.enable {
    networking.wireless = {
      enable = true;
      userControlled = {
        enable = true;
        group = "network";
      };

      secretsFile = config.wireless.secretsFile;

      networks = let
        ensurePasswords = networks: lib.attrsets.mapAttrs (
          name: value: { pskRaw = "ext:psk_" + name; } // value
        ) networks;
      in ensurePasswords config.wireless.networks;
    };

    networking.enableIPv6 = false;
  };
}
