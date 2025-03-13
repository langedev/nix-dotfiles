{ config, ... }:

{
  imports = [ 
    ./hardware.nix
  ];
  system.stateVersion = "24.11";
  system.timezone = "America/Los_Angeles";
  system.users.bigWheels = [ "pan" ];

  shell.enabledShells = [ "fish" ];
  shell.defaultShell = "fish";

  sshd.enable = true;
}

