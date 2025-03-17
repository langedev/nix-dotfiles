{ config, ... }:

{
  imports = [ 
    ./hardware.nix
  ];
  system.stateVersion = "24.11";
  system.timezone = "America/Los_Angeles";
  system.users.bigWheels = [ "pan" ];

  sops-nix = {
    enable = true;
    keyFile = "/etc/sops/age/keys.txt";
    sopsFile = ./secrets.yaml;
    secrets = {
      pdsEnv = {};
    };
  };

  pds = {
    enable = true;
    hostname = "juri.woach.me";
    adminEmail = "admin@woach.me";
    environmentFile = config.sops.secrets.pdsEnv.path;
  };

  shell.enabledShells = [ "fish" ];
  shell.defaultShell = "fish";

  sshd.enable = true;
}

