{ config, lib, ... }:

{
  options.sshd = {
    enable = lib.mkEnableOption "Enables ssh daemon";
    port = lib.mkOption {
      default = 922;
      type = lib.types.port;
    };
  };

  config = lib.mkIf config.sshd.enable {
    services.openssh = {
      enable = true;
      ports = [ config.sshd.port ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
