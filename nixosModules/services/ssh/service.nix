{ config, pkgs, lib, ... }:

{
  options.sshd = {
    enable = lib.mkEnableOption "Enables ssh daemon";
  };

  config = lib.mkIf config.sshd.enable {
    services.openssh.enable = true;
  };
}
