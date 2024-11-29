{ config, lib, ... }:

{
  options.virtualbox = {
    enable = lib.mkEnableOption "Enables virtualbox";
    extra-users = lib.mkOption { default = []; };
  };

  config = lib.mkIf config.virtualbox.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = config.virtualbox.extra-users;
  };
}
