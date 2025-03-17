{ config, pkgs, lib, ... }:

{
  options.sshd = {
    enable = lib.mkEnableOption "Enables ssh daemon";
  };

  config = lib.mkIf config.sshd.enable {
    services.openssh = {
      enable = true;
      ports = [ 922 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
