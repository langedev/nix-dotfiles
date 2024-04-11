{ config, pkgs, lib, ... }:

{
  options.virtualbox = {
    enable = lib.mkEnableOption "Enables virtualbox";
    extra-users = lib.mkOption { default = []; };
  };

  config = lib.mkIf config.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [
      config.user.name
    ] ++ config.virtualbox.extra-users;
  };
}
