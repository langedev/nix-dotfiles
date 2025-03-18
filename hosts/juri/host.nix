{ config, ... }:
let
  email = "admin@woach.me";
in {
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

  caddy = {
    enable = true;
    adminEmail = email;
    vhosts = {
      "juri.woach.me" = {
        extraConfig = ''
          reverse_proxy :3000
        '';
        serverAliases = [ "*.juri.woach.me" ];
      };
    };
  };

  pds = {
    enable = true;
    hostname = "juri.woach.me";
    adminEmail = email;
    environmentFile = config.sops.secrets.pdsEnv.path;
  };

  shell.enabledShells = [ "fish" ];
  shell.defaultShell = "fish";

  sshd.enable = true;
}
