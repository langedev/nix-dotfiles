{ config, ... }:

{
  imports = [
    ./hardware.nix
  ];
  pipewire.enable = true;
  polkit.enable = true;
  bluetooth.enable = true;
  wireless = {
    enable = true;
    networks = builtins.fromTOML (builtins.readFile ./networks.toml);
    secretsFile = config.sops.secrets.wireless.path;
  };

  sops-nix = {
    enable = true;
    keyFile = "/etc/sops/age/keys.txt";
    sopsFile = ./secrets.yaml;
    secrets = {
      wireless = {};
    };
  };

  user.name = "pan";
  user.timezone = "America/Los_Angeles";

  tuigreet.enable = true;
  hyprland.enable = true;

  librewolf.enable = true;
  fish.enable = true;
  fish.setDefault = true;
  syncthing.enable = true;
}
