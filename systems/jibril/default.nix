{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
  ];
  networking.hostName = "jibril";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  sops-nix = {
    enable = true;
    keyFile = "/etc/sops/age/keys.txt";
    sopsFile = ./secrets.yaml;
    secrets = {
      wireless = {};
    };
  };

  pipewire.enable = true;
  polkit.enable = true;
  bluetooth.enable = true;
  wireless = {
    enable = true;
    networks = builtins.fromTOML (builtins.readFile ./networks.toml);
    secretsFile = config.sops.secrets.wireless.path;
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
