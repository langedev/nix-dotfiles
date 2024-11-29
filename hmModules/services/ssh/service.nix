{ config, pkgs, lib, ... }:

{
  options.ssh = {
    enable = lib.mkEnableOption "Enables ssh";
  };

  config = lib.mkIf config.ssh.enable {
    programs.ssh.enable = true;
    home.packages = with pkgs; [
      sshfs # SSH File system
    ];
  };
}
